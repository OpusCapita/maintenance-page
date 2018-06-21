#!/bin/bash

#if [[ -z "$PORT" ]] ; then echo "PORT env is required"; exit 1; fi;
#if [[ -z "$SSLPORT" ]] ; then echo "SSLPORT env is required"; exit 1; fi;
if [[ -z "$SERVERNAME" ]] ; then echo "SERVERNAME env is required"; exit 1; fi;
if [[ -z "$SSL_CERT" ]] ; then echo "SSL_CERT env is required"; exit 1; fi;
if [[ -z "$SSL_PRIVATE_KEY" ]] ; then echo "SSL_PRIVATE_KKEY env is required"; exit 1; fi;

#sed "s/@PORT@/${PORT}/g" nginx.ctmpl > nginx.final
#sed -i "s/@SSLPORT@/${SSLPORT}/g" nginx.final
sed "s/@SERVERNAME@/${SERVERNAME}/g" nginx.ctmpl > nginx.final
cp nginx.final nginx.conf

echo "$SSL_CERT" | base64 -d > sslcert.crt
echo "$SSL_PRIVATE_KEY" | base64 -d > sslkey
echo "\n\nsslcert.crt content:\n"
cat sslcert.crt
echo "\n\nsslkey content:\n"
cat sslkey
nginx -g 'daemon off;'

