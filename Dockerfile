# Stage 1: builder - build the Medusa app and static admin
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies deterministically
COPY package*.json tsconfig.json ./
RUN npm ci

# Copy source and build (expects "build" script in package.json that runs medusa build)
COPY . .
RUN npm run build

# Install production deps inside the generated server output
WORKDIR /app/.medusa/server
RUN npm ci --omit=dev

# Stage 2: runtime - only the built server
FROM node:20-alpine AS runner

WORKDIR /app

# Copy built server from builder
COPY --from=builder /app/.medusa/server ./

ENV NODE_ENV=production
EXPOSE 9000

# Run migrations (predeploy) then start server - follows Medusa docs
CMD ["sh", "-lc", "npm run predeploy && npm run start"]