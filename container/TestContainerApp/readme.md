## Starting via Dapr
dapr run --app-id catestae --app-port 5153 --dapr-http-port 3500 dotnet run

## Accessing via browser using Dapr
http://localhost:3500/v1.0/invoke/catestae/method/someapicall
