#!/bin/bash

# ArulKumar DevOps Assignment - Quick Start Script
# This script helps you get started with the project

echo "========================================="
echo "ArulKumar DevOps Assignment Setup"
echo "========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."

# Check Java
if command -v java &> /dev/null; then
    echo "✅ Java is installed"
    java -version
else
    echo "❌ Java is not installed. Please install Java 17"
    exit 1
fi

# Check Maven
if command -v mvn &> /dev/null; then
    echo "✅ Maven is installed"
    mvn -version
else
    echo "❌ Maven is not installed. Please install Maven 3.9+"
    exit 1
fi

# Check Docker
if command -v docker &> /dev/null; then
    echo "✅ Docker is installed"
    docker --version
else
    echo "❌ Docker is not installed. Please install Docker"
    exit 1
fi

echo ""
echo "========================================="
echo "Building Application - ArulKumar"
echo "========================================="

# Build with Maven
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed"
    exit 1
fi

echo ""
echo "========================================="
echo "Building Docker Image - ArulKumar"
echo "========================================="

# Build Docker image
docker build -t arulkumar-devops-app:latest .

if [ $? -eq 0 ]; then
    echo "✅ Docker image built successfully!"
else
    echo "❌ Docker build failed"
    exit 1
fi

echo ""
echo "========================================="
echo "Starting Application - ArulKumar"
echo "========================================="

# Run Docker container
docker run -d -p 8080:8080 --name arulkumar-devops-container arulkumar-devops-app:latest

if [ $? -eq 0 ]; then
    echo "✅ Application started successfully!"
    echo ""
    echo "Access the application at:"
    echo "  - http://localhost:8080/api/health"
    echo "  - http://localhost:8080/api/welcome"
    echo "  - http://localhost:8080/api/info"
    echo ""
    echo "Created by: ArulKumar"
else
    echo "❌ Failed to start application"
    exit 1
fi

echo "========================================="
