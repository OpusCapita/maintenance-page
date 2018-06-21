docker run -d -e SERVERNAME=localhost -e SSL_CERT=$SSL_CERT -e SSL_PRIVATE_KEY=$SSL_PRIVATE_KEY -p 8443:443 -p 8080:80 opuscapita/maintenance-page:dev
