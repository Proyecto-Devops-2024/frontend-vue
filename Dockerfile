# Utiliza una imagen de Node.js como base para el build
FROM node:14 AS build

# Establece el directorio de trabajo en /app
WORKDIR /app/catalog

# Copia los archivos package.json y package-lock.json al contenedor
COPY package*.json ./

# Instala las dependencias del proyecto
RUN npm install

# Copia todo el código fuente de la aplicación al contenedor
COPY . .

# Construye la aplicación para producción
RUN npm run build

# Utiliza una imagen de Nginx para servir los archivos estáticos
FROM nginx:alpine

# Copia los archivos de build generados al directorio de Nginx
COPY --from=build /home/runner/work/frontend-react/frontend-react/app/catalog/src/ /usr/share/nginx/html

# Expone el puerto 80 para acceder a la aplicación
EXPOSE 80

# Inicia Nginx
CMD ["nginx", "-g", "daemon off;"]
