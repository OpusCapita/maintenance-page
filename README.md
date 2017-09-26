# maintenance-page

This is a very small app that allows to host some static content for maintenance cases.
We are running from nginx base image and adding some static files to /usr/share/nginx/html directory inside container.

## Current env
It is deployed in besTest resource group on OC Azure
Can be reached via public IP:

http://52.174.187.88/

## Activating the maintenance page
Configure the azure DNS domain label of target env to maintenance-page env.
E.g. 
1. Find public IP on prod env, got to configuration and change it from bnp-prod to whatever (you can do this via powershell as well)
2. Find besTest dh1-ip, go to configuration and set to bnp-prod

This will cause all traffic to businessnetwork.opuscapita.com to hit dh1 instead.

## Deployment

```docker secret create kong-ssl-key -```
Then paste the key into stdin. E.g. if setting up maintenance page for prod, use the kong-ssl-key from prod.

```docker service create --name nginx --secret kong-ssl-key --publish mode=host,published=80,target=80 --publish mode=host,published=443,target=443 opuscapita/maintenance-page```

## Development
```sudo docker run --restart always -d -p 80:80 -v /home/<your user name>/maintenance-page:/usr/share/nginx/html opuscapita/maintenance-page```

You can then browse localhost or any public IP your dev box has.

## i18n

Is done via JS in the index.html
The translations are contained in a json scriptlet.
