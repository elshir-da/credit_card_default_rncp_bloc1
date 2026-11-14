
import os
import hmac
from getpass import getpass
from urllib.parse import quote_plus

from flask import Flask, jsonify, request
from sqlalchemy import create_engine, text

app = Flask(__name__)

# API Key authentication
API_KEY = os.environ.get("CREDIT_API_KEY")

if not API_KEY:
    raise RuntimeError("CREDIT_API_KEY is required.")

# MySQL connection
password = getpass("Enter MySQL password: ")

engine = create_engine(
    f"mysql+pymysql://root:{quote_plus(password)}"
    "@localhost:3306/credit_card_default_db"
)

@app.before_request
def check_api_key():
    provided_key = request.headers.get("X-API-Key", "")

    if not hmac.compare_digest(provided_key, API_KEY):
        return jsonify({"error": "Unauthorized"}), 401


@app.route("/customers/count", methods=["GET"])
def customer_count():
    with engine.connect() as conn:
        count = conn.execute(
            text("SELECT COUNT(*) FROM customers")
        ).scalar()

    return jsonify({"total_customers": int(count)})


@app.route("/defaults/summary", methods=["GET"])
def default_summary():
    with engine.connect() as conn:
        row = conn.execute(text("""
            SELECT
                COUNT(*) AS total_customers,
                SUM(default_next_month = 1) AS default_customers,
                ROUND(AVG(default_next_month) * 100, 2)
                    AS default_rate_percent
            FROM customers
        """)).mappings().one()

    return jsonify({
        "total_customers": int(row["total_customers"]),
        "default_customers": int(row["default_customers"]),
        "default_rate_percent": float(row["default_rate_percent"])
    })



# Endpoint 3: List customers with pagination
@app.route("/customers", methods=["GET"])
def list_customers():
    page = max(request.args.get("page", 1, type=int), 1)
    limit = min(max(request.args.get("limit", 10, type=int), 1), 100)
    offset = (page - 1) * limit

    with engine.connect() as conn:
        rows = conn.execute(text("""
            SELECT customer_id, age, limit_bal, default_next_month
            FROM customers
            ORDER BY customer_id
            LIMIT :limit OFFSET :offset
        """), {"limit": limit, "offset": offset}).mappings().all()

    return jsonify({
        "page": page,
        "limit": limit,
        "customers": [dict(row) for row in rows]
    })


# Endpoint 4: Get a single customer
@app.route("/customers/<int:customer_id>", methods=["GET"])
def get_customer(customer_id):
    with engine.connect() as conn:
        row = conn.execute(text("""
            SELECT customer_id, age, limit_bal, default_next_month
            FROM customers
            WHERE customer_id = :customer_id
        """), {"customer_id": customer_id}).mappings().first()

    if row is None:
        return jsonify({"error": "Customer not found"}), 404

    return jsonify(dict(row))


if __name__ == "__main__":
    app.run(debug=False)
