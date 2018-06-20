sed "s/@PORT@/${PORT}/g" nginx.ctmpl > nginx.final
sed -i "s/@SSLPORT@/${SSLPORT}/g" nginx.final
sed -i "s/@SERVERNAME@/${SERVERNAME}/g" nginx.final
cp nginx.final nginx.final

