# Web portal — Next.js

Browser portal for **HR, company and admin** staff. Employees use the Flutter
mobile app instead.

## Stack

- Next.js 16.4 (App Router) with React 19
- TypeScript

## Run locally

```bash
npm install
npm run dev
```

Open http://localhost:3000.

## Scripts

| Command | Purpose |
|---|---|
| `npm run dev` | Development server with hot reload |
| `npm run build` | Production build |
| `npm start` | Serve the production build |
| `npm run lint` | ESLint |
| `npm run typecheck` | TypeScript check without emitting |

## Talking to the backend

The API base URL is read from `NEXT_PUBLIC_API_BASE_URL` and defaults to
`http://localhost:8080/api`.

Because `NEXT_PUBLIC_*` variables are **inlined into the client bundle at build
time**, changing the value requires a rebuild, not just a container restart.
The Docker `build` service passes it as a build arg for that reason.

## Notes

- `next.config.ts` sets `output: "standalone"`, which produces a minimal server
  bundle. This is what the Dockerfile ships; do not remove it without also
  changing the Dockerfile.
- Server-side calls to the API should use an internal URL such as
  `http://backend:8080/api`, while browser-side calls use the public URL. Only
  the public URL is exposed to the client.