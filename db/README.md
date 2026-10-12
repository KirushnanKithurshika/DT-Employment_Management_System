# Database — PostgreSQL 18

PostgreSQL runs from the official `postgres:18.6-alpine` image, so **there is no
Dockerfile here by design**. The image already provides the entrypoint, user
management and volume handling that a hand-written one would have to recreate.

## How scripts are applied

Files in `init/` are mounted to `/docker-entrypoint-initdb.d` and run in
alphabetical order, but **only when the database volume is empty**.

Consequences:

- Editing `01_initial_schema.sql` after you have already started the stack has
  **no effect**.
- To re-apply scripts from scratch: `docker compose down -v && docker compose up db`

Keep migrations additive. Never modify a script that has been applied to a
shared database — add a new numbered file instead.

## Current schema

| Table | Purpose |
|---|---|
| `departments` | Organisational departments |
| `designations` | Job titles, linked to a department |
| `branches` | Physical company locations |
| `employees` | Core employee records |
| `leave_requests` | Leave applications raised by employees |

## Connecting

```bash
docker compose exec db psql -U ems -d ems
```

Defaults come from `.env` (`POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`).

## Ownership

The schema is owned by these SQL scripts, never by Hibernate. The backend runs
with `ddl-auto: validate` so that a schema mismatch fails fast at startup
instead of being silently patched by the application.

## Note on the design docs

A larger DDL exists in the group's design documentation. It has deliberately
**not** been imported here: this file is a minimal runnable baseline so the
stack comes up on day one. Reconciling the two belongs in the database phase,
after review, rather than being folded into the root setup.