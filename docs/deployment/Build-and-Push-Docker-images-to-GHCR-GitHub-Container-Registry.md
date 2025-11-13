# Build and Push Docker images to GHCR (GitHub Container Registry)

This guide shows how to build a linux/amd64 image and push it to GHCR from your Mac (zsh).

## Prerequisites

- Docker Desktop with Buildx enabled (default on recent Docker Desktop).
- A GitHub Personal Access Token (classic) with scope: write:packages (read:packages for pulls).
- Environment variables set in your shell:
  ```sh
  export GHCR_USERNAME="calumbradley"
  export GHCR_TOKEN="YOUR_PAT_WITH_write:packages"
  ```

## 1) Login to GHCR

- Auth Docker to your GHCR account.
  ```sh
  echo "$GHCR_TOKEN" | docker login ghcr.io -u "$GHCR_USERNAME" --password-stdin
  ```

## 2) (Optional) Ensure Buildx is ready

- Create/select a builder if Docker complains buildx isn’t configured.
  ```sh
  docker buildx create --use || true
  docker buildx ls
  ```

## 3) Build and push from the root Dockerfile (debug image)

- Builds for linux/amd64 and pushes two tags: a stable name and the short commit SHA.

  ```sh
  IMAGE="ghcr.io/calumbradley/chester-pup"
  DOCKERFILE="Dockerfile"                  # uses the root Dockerfile
  TAG="server-debug"                       # change to server-latest if you prefer
  SHA="$(git rev-parse --short HEAD)"

  docker buildx build \
    --platform linux/amd64 \
    -f "$DOCKERFILE" \
    -t "$IMAGE:$TAG" \
    -t "$IMAGE:$TAG-$SHA" \
    --push \
    .
  ```

## 4) Alternative: Build and push using Dockerfile.server

- Use this if you want the production Medusa start flow.

  ```sh
  IMAGE="ghcr.io/calumbradley/chester-pup"
  DOCKERFILE="Dockerfile.server"
  TAG="server-latest"
  SHA="$(git rev-parse --short HEAD)"

  docker buildx build \
    --platform linux/amd64 \
    -f "$DOCKERFILE" \
    -t "$IMAGE:$TAG" \
    -t "$IMAGE:$TAG-$SHA" \
    --push \
    .
  ```

## 5) Optional: Worker image (if you add Dockerfile.worker later)

```sh
IMAGE="ghcr.io/calumbradley/chester-pup"
DOCKERFILE="Dockerfile.worker"
TAG="worker-latest"
SHA="$(git rev-parse --short HEAD)"

docker buildx build \
  --platform linux/amd64 \
  -f "$DOCKERFILE" \
  -t "$IMAGE:$TAG" \
  -t "$IMAGE:$TAG-$SHA" \
  --push \
  .
```

## Notes

- Visibility: GHCR packages are private by default. Make the image public from the GitHub Packages UI (Packages → chester-pup → Package settings → Change visibility).
- Apple Silicon: The --platform linux/amd64 flag ensures compatibility with DO droplets and many cloud runtimes.
- Troubleshooting:
  - denied: permission_denied → ensure the PAT includes write:packages and you’re logging in as the correct user.
  - no builder instance → run the “Ensure Buildx is ready” step.
