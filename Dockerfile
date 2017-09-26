FROM nginx
MAINTAINER gr4per

WORKDIR /usr/share/nginx/html

# copy static resource to container
COPY . .

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --retries=12 \
  CMD curl --silent --fail http://localhost:80/index.html || exit 1

