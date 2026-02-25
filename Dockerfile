# ArulKumar DevOps Assignment - Dockerfile
# Multi-stage build for optimized image

# Stage 1: Build Stage
FROM maven:3.9.5-eclipse-temurin-17 AS build
LABEL maintainer="ArulKumar"
LABEL description="DevOps Sharpened DAP Completion Assignment"

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime Stage
FROM eclipse-temurin:17-jre-alpine
LABEL maintainer="ArulKumar"
LABEL application="arulkumar-devops-app"
LABEL version="1.0.0"

# Create app directory
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/arulkumar-devops-app.jar app.jar

# Expose application port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/health || exit 1

# Environment variables
ENV SPRING_PROFILES_ACTIVE=prod
ENV DEVELOPER_NAME=ArulKumar

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
CMD ["--spring.application.name=arulkumar-devops-app"]
