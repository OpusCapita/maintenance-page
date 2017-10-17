FROM nginx
MAINTAINER gr4per

WORKDIR /usr/share/nginx/html

# copy static resource to container
COPY content .
COPY nginx.conf /etc/nginx/nginx.conf
COPY businessnetwork_opuscapita_com.crt /etc/nginx/businessnetwork_opuscapita_com.crt
EXPOSE 80
EXPOSE 443

HEALTHCHECK --interval=15s --timeout=3s --retries=12 \
  CMD curl --silent --fail http://localhost:80/index.html || exit 1

