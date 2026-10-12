# Backend — Spring Boot (Java 21)

REST API for the Employment Management System. Serves both the web portal
(HR, company, admin) and the mobile app (employees).

## Stack

- Java 21
- Spring Boot 4.1 (Web, Data JPA, Validation, Actuator)
- PostgreSQL 18

## Run locally

```bash
./mvnw spring-boot:run
```

The Maven wrapper (`mvnw`) is checked in, so no local Maven install is required.

## Test

```bash
./mvnw verify
```

Tests run against an in-memory H2 database, so no PostgreSQL instance is needed
to execute the suite.

## Endpoints

| Method | Path | Purpose |
|---|---|---|
| GET | `/api/system/info` | Service identity / liveness for clients |
| GET | `/actuator/health` | Health probe (used by docker-compose) |

## Configuration

Read from the environment, with local defaults in
`src/main/resources/application.yml`:

| Variable | Default |
|---|---|
| `SPRING_DATASOURCE_URL` | `jdbc:postgresql://localhost:5432/ems` |
| `SPRING_DATASOURCE_USERNAME` | `ems` |
| `SPRING_DATASOURCE_PASSWORD` | `ems_local_dev_password` |
| `BACKEND_PORT` | `8080` |

## Schema ownership

Hibernate is set to `ddl-auto: validate` and never creates tables. The schema is
owned by `db/init/*.sql` so the database remains reproducible and reviewable
outside the application.