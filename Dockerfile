# Production build for Strapi CMS v4
# -------- STAGE 1: Build Strapi --------
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy dependency manifests first
COPY package*.json ./


# Install dependencies (including devDeps for build)
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the Strapi admin panel
RUN npm run build

# -------- STAGE 2: Run Strapi --------
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app ./

# Remove development dependencies
RUN npm prune --omit=dev

# Expose the port Strapi listens on
EXPOSE 1337

# Set environment variables
ENV NODE_ENV=production

# Start Strapi
CMD ["npm", "run", "start"]