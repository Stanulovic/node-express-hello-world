# IZBJEGAVAMO Docker Hub
# Docker Official Image mirror na ECR Public:
#   public.ecr.aws/docker/library/node:<tag>
FROM public.ecr.aws/docker/library/node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev || npm install --omit=dev

COPY . .

ENV PORT=3000
EXPOSE 3000

# (opciono) non-root
USER node

# (opciono) HEALTHCHECK ako dodaš /healthz
# HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
#   CMD wget -qO- http://127.0.0.1:${PORT}/healthz || exit 1

CMD ["npm", "start"]