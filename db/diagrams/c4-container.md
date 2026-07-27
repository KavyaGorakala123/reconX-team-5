'''mermaid
C4Container
    title C4 Container - ReconX 

    Person(user, "User", "Trader / Analyst / Admin")
    System_Ext(oms, "Internal OMS", "Upstream trade source")
    System_Ext(sso, "Corporate SSO", "OIDC IdP")

    System_Boundary(reconxBoundary, "ReconX") {
        Container(ui, "Recon UI", "React 19 + Vite", "Singlr-page app. Live trade feed via SSE, trade execution, break queues, admin views.")
        Container(api, "recon-service API", "Java 21 + Spring Boot 3 ", "REST API, JWT auth, RBAC, validation, exposes /actuator/prometheus.")
        Container(engine, "Reconciliation Engine", "Spring + CompletableFuture", "Async batch + streaming match logic. Writes recon breaks.")
        Container(db, "PostgreSQL 16", "Lquidbase-managed", "Partitioned trades, recon_breaks, audit_log, mat views.")
        ContainerQueue(kafka, "Apache kafka"."3 topics + DLQs","trade-events, recon_results, system-alerts. DLQ per topic.")
        Container(prometheus, "Prometheus", "TSDB","Scrapes the API every 15s.")
        Container (grafna , "Grafna", "Dashboard","Pre-provisioned dashboards.")
    }
    Rel(user, ui , "Uses", "HTTPS")
    Rel(user, sso , "Login", "OIDC / HTTPS")
    Rel(oms, kafka, "Publishes trade events", "kafka protocol")

    Rel(ui, api, "REST + SSE", "HTTPS")
    Rel(ui, sso, "Login", "OIDC / HTTPS")

    Rel(api, db, "Reads + writes", "JDBC")
    Rel(api, kafka, "Publishes/consumes", "kafka protocol")

    Rel(engine, kafka, "Consumes trade events" , "kafka protocol" )
    Rel(engine, db, "Writes recon results", "JDBC")

    Rel(prometheus, api, "Scrapes /actuator/promethus", "HTTPS")
    Rel(grafna, prometheus, "Queries", "HTTPS")
'''
