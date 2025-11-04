# Base image
FROM public.ecr.aws/docker/library/node:20-alpine

# Radni dir
WORKDIR /app

# Samo manifesti prvo (bolji cache)
COPY package*.json ./

# Prod zavisnosti (ci ako ima lock, fallback na install)
RUN npm ci --omit=dev || npm install --omit=dev

# Kopiraj ostatak app-a
COPY . .

# ENV i ne-root korisnik
ENV NODE_ENV=production
ENV PORT=3000

# (Opcija) Healthcheck – napravi /healthz rutu u app-u
# HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:${PORT}/healthz || exit 1

# Izloži interni port aplikacije
EXPOSE 3000

# Koristi ne-root usera "node"
USER node

# Start
CMD ["node", "app.js"]
