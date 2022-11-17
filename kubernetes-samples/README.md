
```
cd src/LivenessTest
dotnet publish -c Release -r linux-x64 --no-self-contained
docker build --pull -t acidicmercury8/livenesstest .
docker push acidicmercury8/livenesstest:latest
docker run --rm -it -p 8000:5001 -p 8001:5003 -e ASPNETCORE_URLS="https://+:5003;http://+:5001" -e ASPNETCORE_HTTPS_PORT=8001 -e ASPNETCORE_ENVIRONMENT=Development -e ASPNETCORE_Kestrel__Certificates__Development__Password="1243" -v ${HOME}/.microsoft/usersecrets/:/root/.microsoft/usersecrets -v ${HOME}/.aspnet/https:/root/.aspnet/https/ acidicmercury8/livenesstest:latest
curl http://localhost:8080/api/Lorem
```
