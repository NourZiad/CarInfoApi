# Base image for running
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 5000

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy everything
COPY . .

# Enter the actual project folder
WORKDIR /src/CarInfoApi

# Restore dependencies
RUN dotnet restore

# Publish the app
RUN dotnet publish -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "CarInfoApi.dll"]
