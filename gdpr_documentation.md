# RNCP C4 — GDPR and Data Protection Documentation

## 1. Purpose of Data Processing

This educational project analyzes historical credit card customer data to study payment default risk and demonstrate data engineering techniques.

The processing activities include data cleaning, machine learning, MySQL storage, SQL analysis, BigQuery queries, and local Flask API access.

The project is a proof of concept and is not used to make real banking decisions.

## 2. Data Sources and Categories

| Source | Data Categories | Purpose |
|---|---|---|
| UCI Credit Card Dataset | Customer IDs, demographic codes, credit limits, repayment history, billing and payment amounts, default labels | Machine learning and SQL analysis |
| NCCC Open API | Annual aggregated credit card statistics | Industry context |
| FSC Public Website | Aggregated financial indicators | Industry context |

The UCI dataset contains historical Taiwan credit card records from 2005. The external industry datasets are processed separately and are not linked to individual UCI customer records.

## 3. Personal Data and Privacy Considerations

The UCI dataset does not provide customer names or direct contact information. However, customer-level financial and demographic records may still require privacy safeguards.

Customer identifiers are used for relational database operations and should not be treated as proof of full anonymization.

No attempt is made to re-identify individuals.

The applicability of GDPR, including any applicable legal basis and data subject rights obligations, would require a formal assessment before real-world processing.

## 4. Data Processing Register

| Processing Activity | Purpose | Storage | Access |
|---|---|---|---|
| CSV processing | Cleaning and preparation | Local project files | Project developer |
| MySQL storage | Relational data management | Local MySQL database | Database account |
| BigQuery analysis | Cloud-based SQL queries | Google BigQuery | Authorized project account |
| Flask API | Demonstration of data access | Local API connected to MySQL | API Key required |
| External data collection | Industry-level context | Local CSV files | Project developer |

## 5. Data Protection Measures

The project includes the following basic safeguards:

- MySQL passwords are entered at runtime and are not intentionally hardcoded in the source code.
- Flask API access is restricted using an API Key stored in an environment variable.
- The Flask application is intended for local demonstration only.
- SQL queries use parameterized inputs for customer lookups.
- Public GitHub files should not contain passwords, API keys, or database credentials.
- Access to customer-level records should be limited to authorized users.

These measures are appropriate for a basic educational demonstration but are not sufficient evidence of production-level GDPR compliance.

## 6. Data Retention and Deletion

The project datasets are retained only as necessary for educational development, assessment, and reproducibility.

A final retention period has not been formally established and should be determined according to the applicable school, platform, and legal requirements.

For deletion requests or project cleanup:

1. Identify the relevant customer record using `customer_id`.
2. Identify related repayment, billing, and payment history records.
3. Delete dependent records before deleting the customer record, respecting foreign key constraints.
4. Verify that the records have been removed.
5. Consider whether related local CSV exports, backups, and cloud copies also require deletion.

Deleting a row from MySQL alone does not remove copies in CSV files, notebooks, backups, or BigQuery.

## 7. Data Minimization

Only fields required for the analytical and educational objectives should be retained or exposed.

Customer-level API responses are provided solely for local demonstration. A real-world banking API would require stronger authorization, logging, transport security, and controls over sensitive information.

## 8. Limitations and Further Requirements

This document describes a basic data protection approach, not a formal GDPR compliance certification.

Before production use, the project would require a documented legal assessment, validated retention policies, appropriate security controls, and organizational governance.