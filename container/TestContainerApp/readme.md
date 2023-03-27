## Starting via Dapr
dapr run --app-id catestae --app-port 5153 --dapr-http-port 3500 dotnet run

## Accessing via browser using Dapr
http://localhost:3500/v1.0/invoke/catestae/method/someapicall

## Login to ACR
az acr login --name acrtstae

Note: Full Name of ACR should be acrtstae.azurecr.io

## Tag image
docker tag testcontainerapp:dev acrtstae.azurecr.io/testcontainerapp:v1

## And publish to ACR
docker push acrtstae.azurecr.io/testcontainerapp:v1

## List images in ACR
az acr repository list --name acrtstae  --output table

