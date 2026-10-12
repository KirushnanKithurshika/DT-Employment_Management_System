# DT — Employment Management System

An Employee Management System for DreamTrillions: a web portal for HR, company and
admin staff, paired with a mobile app for employees.

---

## Repository layout

```
.
├── backend/    Spring Boot 4 (Java 21) REST API
├── web/        Next.js 16 portal  — HR, company and admin staff
├── mobile/     Flutter app        — employees
├── db/         PostgreSQL init scripts
└── docker-compose.yml
```

`backend` and `web` are split by audience on purpose: internal back-office users
work in the browser, employees work from the phone.

## Prerequisites

- Docker Desktop / Docker Engine with Compose v2
- Nothing else is required to run the whole stack

## Clone

```bash
git clone https://github.com/KirushnanKithurshika/DT-Employment_Management_System.git
cd DT-Employment_Management_System
```

## Run the system

```bash
cp .env.example .env      # then edit the passwords if you want non-default ones
docker compose up --build
```

| Service | URL / port |
|---|---|
| Web portal | http://localhost:3000 |
| Backend API | http://localhost:8080/actuator/health |
| PostgreSQL | `localhost:5432` |

Stop with `docker compose down`. Add `-v` to also delete the database volume
(permanent data loss).

## Run without Docker

<details>
<summary>Backend</summary>

Requires JDK 21 and the bundled Maven wrapper (no local Maven install needed):

```bash
cd backend
./mvnw spring-boot:run
```
</details>

<details>
<summary>Web</summary>

Requires Node.js 22+:

```bash
cd web
npm install
npm run dev
```
</details>

<details>
<summary>Database only</summary>

```bash
docker compose up db
```
</details>

## Database

`db/init/*.sql` runs automatically the first time the volume is created. Because
PostgreSQL only executes that directory on first initialisation, adding a script
later requires either a manual `psql` run or `docker compose down -v`.

## Contributing

`main` is production and `develop` is the default integration branch. Work on
`phase/*` or `feature/*` branches branched from `develop`, and open a pull request
into `develop`. See `CONTRIBUTING.md`.