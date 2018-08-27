#!/bin/bash

#if [[ -z "$PORT" ]] ; then echo "PORT env is required"; exit 1; fi;
#if [[ -z "$SSLPORT" ]] ; then echo "SSLPORT env is required"; exit 1; fi;
if [[ -z "$SERVERNAME" ]] ; then echo "SERVERNAME env is required"; exit 1; fi;
ssl=true
if [[ -z "$SSL_CERT" ]] ; then 
  echo "SSL_CERT env not set, turning off ssl"; 
  ssl=false  
fi;

if [[ -z "$SSL_PRIVATE_KEY" ]] ; then 
  echo "SSL_PRIVATE_KKEY env not set, turning off ssl"; 
  ssl=false 
fi;

if [[ "$ssl" == "false" ]] ; then 
  grep -v "listen 443 ssl" nginx.ctmpl > nginx.tmp
  grep -v "ssl_certificate" nginx.tmp > nginx.ctmpl
  grep -v "ssl_certificate_key" nginx.ctmpl > nginx.tmp
  cp nginx.tmp nginx.ctmpl
else
  echo "$SSL_CERT" | base64 -d > sslcert.crt
  echo "$SSL_PRIVATE_KEY" | base64 -d > sslkey
fi;

#sed "s/@PORT@/${PORT}/g" nginx.ctmpl > nginx.final
#sed -i "s/@SSLPORT@/${SSLPORT}/g" nginx.final
sed "s/@SERVERNAME@/${SERVERNAME}/g" nginx.ctmpl > nginx.final
cp nginx.final nginx.conf

#echo "\n\nsslcert.crt content:\n"
#cat sslcert.crt
#echo "\n\nsslkey content:\n"
#cat sslkey
nginx -g 'daemon off;'

