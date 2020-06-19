# Container solo para build el proyecto, aqui solo constrimos el proyecto
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Server container donde vamos a copiar el resultadod e construir el proyecto al servidor de nginx  (Listo para PRODUCCION)
FROM nginx
EXPOSE 80
# --from=builder   <-- Expecificamos el Tag de dende vamos a copiar, en este caso es de el container anterior builder
COPY --from=builder /app/build /usr/share/nginx/html