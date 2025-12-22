# Production Runtime for Strapi CMS
# This Dockerfile expects 'dist', 'public', and 'package.json' to be available in the context
# (built by GitHub Actions)

FROM node:20-alpine

WORKDIR /app

# Set environment to production
ENV NODE_ENV=production

# Copy dependency manifests
COPY package*.json ./

# Install production dependencies
# doing this *inside* the container ensures compatibility with Alpine Linux
RUN npm ci --omit=dev

# Copy the built application artifacts
COPY dist ./dist
COPY public ./public
COPY config ./config
COPY favicon.png ./
COPY database ./database

# Expose port
EXPOSE 1337

# Start Strapi
CMD ["npm", "run", "start"]