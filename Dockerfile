FROM nginx
MAINTAINER gr4per

WORKDIR /usr/share/nginx/html

# copy static resource to container
COPY content .
WORKDIR /etc/nginx
COPY nginx.ctmpl /etc/nginx/nginx.ctmpl
COPY entrypoint.sh /etc/nginx/
EXPOSE 80
EXPOSE 443

HEALTHCHECK --interval=15s --timeout=3s --retries=12 \
  CMD curl --silent --fail http://localhost:80/index.html || exit 1

CMD /etc/nginx/entrypoint.sh
