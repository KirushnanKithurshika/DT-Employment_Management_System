import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Emits a self-contained server bundle that the Dockerfile copies directly,
  // which keeps the runtime image small and free of node_modules.
  output: "standalone",
  reactStrictMode: true,
  env: {
    NEXT_PUBLIC_API_BASE_URL:
      process.env.NEXT_PUBLIC_API_BASE_URL ?? "http://localhost:8080/api",
  },
};

export default nextConfig;