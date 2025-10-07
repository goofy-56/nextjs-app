# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY next-app/package*.json ./
RUN npm install --production=false
COPY next-app/ ./
RUN npm run build

# Stage 2: Run
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app .
EXPOSE 3000
CMD ["npm", "start"]
