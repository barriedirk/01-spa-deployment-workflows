# === ETAPA 1: Construcción (Builder) ===
FROM node:20-alpine AS builder

# Instalar pnpm globalmente en el contenedor
RUN npm install -g pnpm

WORKDIR /app

# Copiar archivos de configuración de dependencias primero (aprovecha el caché de Docker)
COPY package.json pnpm-lock.yaml* ./

# Instalar dependencias
RUN pnpm install --frozen-lockfile

# Copiar el resto del código fuente del proyecto
COPY . .

# Compilar la aplicación para producción (genera la carpeta dist/ o build/)
RUN pnpm build

# === ETAPA 2: Servidor de Producción (Runner) ===
FROM nginx:1.25-alpine

# Copiar los archivos estáticos compilados desde la etapa anterior al directorio de Nginx
# NOTA: Cambia "dist" por "build" si tu framework genera esa carpeta (ej. Create React App antigua)
COPY --from=builder /app/dist /usr/share/nginx/html

# Exponer el puerto 80 del contenedor
EXPOSE 80

# Arrancar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]