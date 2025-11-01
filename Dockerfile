# Dockerfile para express-pokemonsApi
FROM node:18-alpine

WORKDIR /app

# Copiamos package.json y lock primero para aprovechar cache
COPY . .

# Instalamos dependencias
RUN npm ci --omit=dev

# Copiamos el resto del código fuente
COPY . .

# Variable de entorno del puerto
ENV PORT=8080
EXPOSE 8080

# Comando de arranque
CMD ["npm", "start"]
