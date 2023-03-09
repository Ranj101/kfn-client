FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /src
COPY src/KfnClient/KfnClient.csproj KfnClient/
RUN dotnet restore KfnClient/KfnClient.csproj

COPY src .

WORKDIR /src/KfnClient

RUN dotnet build KfnClient.csproj --no-restore -c Release

FROM build AS publish
RUN dotnet publish KfnClient.csproj --no-build -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "KfnClient.dll"]
