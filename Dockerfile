# Stage 1: builder - build the Medusa app and static admin
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies deterministically with npm cache
COPY package*.json tsconfig.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Copy source and build (expects "build" script in package.json that runs medusa build)
COPY . .
RUN npm run build

# Install production deps inside the generated server output with cache
WORKDIR /app/.medusa/server
RUN --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# Stage 2: runtime - only the built server
FROM node:20-alpine AS runner

WORKDIR /app

# Include Postgres tools and CA certificates for RDS TLS
RUN apk add --no-cache postgresql-client

# Copy built server from builder
COPY --from=builder /app/.medusa/server ./

ENV NODE_ENV=production
EXPOSE 9000

# Run migrations (predeploy) then start server - follows Medusa docs
CMD ["sh", "-lc", "npm run predeploy && npm run start"]