FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
EXPOSE 5001
EXPOSE 5003

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["LivenessTest.csproj", "./"]
RUN dotnet restore "LivenessTest.csproj"
COPY . .
RUN dotnet build "LivenessTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LivenessTest.csproj" -c Release -o /app/publish -r linux-x64 -p:UseAppHost=false --no-self-contained

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LivenessTest.dll"]
