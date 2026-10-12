# Contributing

## Branches

| Branch | Purpose | Merges from |
|---|---|---|
| `main` | Production. Protected — releases only. | `develop` |
| `develop` | Default branch. Integration branch. | `phase/*`, `feature/*` |
| `phase/<n>-<name>` | A project phase, e.g. `phase/00-project-root-setup` | `develop` |
| `feature/<name>` | A single feature inside a phase | `develop` |

Flow: branch from `develop` → work → open a pull request into `develop` →
review → merge → release `develop` into `main`.

Never commit directly to `main` or `develop`. Never branch from `main` for
day-to-day work.

## Naming

```
phase/00-project-root-setup
phase/01-database
phase/02-backend-core
feature/employee-search
feature/leave-approval
```

Use a lowercase, hyphen-separated description. Keep the numeric phase prefix
so branches sort in the order the project is planned.

## Review policy

**Every pull request must be reviewed and approved by
[@KirushnanKithurshika](https://github.com/KirushnanKithurshika) before it can
be merged into `develop` or `main`.**

Workflow for a change:

1. Create your branch from an up-to-date `develop`.
2. Push and open a pull request targeting `develop`.
3. Tag the supervisor so she is notified.
4. Wait for her approval. Push fixes as new commits on the same branch — the
   pull request updates automatically.
5. Merge only once she approves. Squash-merge unless history is useful.

### Technical enforcement

Repository settings are configured to require an approving review and block
merges without one. If you can merge into `main` or `develop` without an
approval, **stop and tell the supervisor** — it means the protection has been
removed or bypassed, which is itself a bug in the process.

## Before you open a pull request

CI must be green. It runs, per component:

| Check | What it does |
|---|---|
| Backend | `./mvnw verify` (compile + tests) and a Docker image build |
| Web | ESLint, TypeScript check, production build and image build |
| Mobile | `flutter analyze` and `flutter test` |
| Infrastructure | `docker compose config` validation and presence of `.env.example` |
| Schema | `db/init` contains at least one `.sql` file |

Locally, before pushing:

```bash
cd backend && ./mvnw verify
cd web     && npm install && npm run lint && npm run typecheck && npm run build
docker compose config --quiet
```

## Running locally

See the root `README.md`. In short: `cp .env.example .env && docker compose up --build`.

## Secrets

Never commit `.env` or any credential. Local defaults live in `.env.example`,
which contains throwaway passwords only.