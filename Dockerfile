FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
# Copy everything
COPY . .
# Restore as distinct layers
RUN dotnet restore "./OnlineShoppingApi/OnlineShoppingApi.csproj"
# Build and publish a release
RUN dotnet publish "./OnlineShoppingApi/OnlineShoppingApi.csproj" -c Release -o app

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 5000
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "OnlineShoppingApi.dll"]