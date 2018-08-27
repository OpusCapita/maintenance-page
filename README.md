# maintenance-page

This is a very small app that allows to host some static content for maintenance cases.
We are running from nginx base image and adding some static files to /usr/share/nginx/html directory inside container via bind mount

## Deployment

We deploy this on edge nodes in each target andariel that needs it. Same as kong it requires kong-ssl-key to be added as docker secret in order to use SSL Certs.
Also in current version you need to checkout mainenance-page github to local disk on each of the target edge nodes and then define a docker service that maps them via bind mount.

```docker service create --name maintenance-page --secret kong-ssl-key --constraint "engine.labels.nodetype==edge" --mount type=bind,source=/home/gr4per/maintenance-page/html,destination=/usr/share/nginx/html --publish 80:80 --publish 443:443 opuscapita/maintenance-page```

## Activating the maintenance page

In order to access it, we need to adjust the load balancing rules to point to 80/443 locally instead of 8080/8443 (which is kong).
This will cause all traffic to businessnetwork.opuscapita.com to hit dh1 instead.

## Development
```sudo docker run --restart always -d -p 80:80 -v /home/<your user name>/maintenance-page/html:/usr/share/nginx/html opuscapita/maintenance-page```

You can then browse localhost or any public IP your dev box has.

## i18n

Is done via JS in the index.html
The translations are contained in a json scriptlet.
