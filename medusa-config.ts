import { defineConfig } from "@medusajs/framework/utils";

export default defineConfig({
  projectConfig: {
    // Distinguish server/worker/shared at runtime
    workerMode: process.env.MEDUSA_WORKER_MODE as
      | "shared"
      | "worker"
      | "server",

    // Database and Redis connections come from env (docs recommend these)
    databaseUrl: process.env.DATABASE_URL,
    redisUrl: process.env.REDIS_URL,

    // HTTP configuration (required)
    http: {
      storeCors: process.env.STORE_CORS || "",
      adminCors: process.env.ADMIN_CORS || "",
      authCors: process.env.AUTH_CORS || "",
      jwtSecret: process.env.JWT_SECRET || "supersecret",
      cookieSecret: process.env.COOKIE_SECRET || "supersecret",
    },
  },

  admin: {
    // Disable the admin for worker instances
    disable: process.env.DISABLE_MEDUSA_ADMIN === "true",

    // Backend URL used by the static admin build
    backendUrl: process.env.MEDUSA_BACKEND_URL,
  },
});
