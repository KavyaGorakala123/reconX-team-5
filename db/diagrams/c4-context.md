\# ReconX C4 Context Diagram



```mermaid

C4Context



title ReconX System Context Diagram



Person(trader, "Trader", "Executes and monitors trading activities")

Person(reconAnalyst, "Recon Analyst", "Performs reconciliation and investigates breaks")

Person(opsAdmin, "Ops Admin", "Manages operational configuration and support")

Person(compliance, "Compliance Officer", "Reviews compliance and audit information")



System(reconx, "ReconX", "Trade reconciliation platform that compares records, detects breaks, and provides operational insights")



System\_Ext(oms, "Order Management System (OMS)", "Provides trade orders and execution information")

System\_Ext(sftp, "Counterparty SFTP", "Provides external trade files")

System\_Ext(bloomberg, "Bloomberg", "Provides market and reference data")

System\_Ext(email, "Email Gateway", "Sends alerts and notifications")

System\_Ext(sso, "SSO Identity Provider", "Provides authentication and authorization")

System\_Ext(grafana, "Grafana", "Provides monitoring dashboards")



Rel(trader, reconx, "Views reconciliation status and trade information", "HTTPS")

Rel(reconAnalyst, reconx, "Investigates reconciliation breaks", "HTTPS")

Rel(opsAdmin, reconx, "Manages operations and configuration", "HTTPS")

Rel(compliance, reconx, "Reviews audit and compliance reports", "HTTPS")



Rel(oms, reconx, "Provides trade execution data", "Kafka")

Rel(sftp, reconx, "Uploads counterparty trade files", "SFTP")

Rel(bloomberg, reconx, "Provides market reference data", "HTTPS")

Rel(reconx, email, "Sends reconciliation alerts", "SMTP")

Rel(reconx, sso, "Authenticates users", "OIDC")

Rel(reconx, grafana, "Exports operational metrics", "HTTPS")

```

