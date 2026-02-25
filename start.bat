@echo off
REM ArulKumar DevOps Assignment - Quick Start Script (Windows)
REM This script helps you get started with the project

echo =========================================
echo ArulKumar DevOps Assignment Setup
echo =========================================
echo.

REM Check prerequisites
echo Checking prerequisites...

REM Check Java
java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [32mOK Java is installed[0m
    java -version
) else (
    echo [31mX Java is not installed. Please install Java 17[0m
    exit /b 1
)

REM Check Maven
mvn -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [32mOK Maven is installed[0m
    mvn -version
) else (
    echo [31mX Maven is not installed. Please install Maven 3.9+[0m
    exit /b 1
)

REM Check Docker
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [32mOK Docker is installed[0m
    docker --version
) else (
    echo [31mX Docker is not installed. Please install Docker[0m
    exit /b 1
)

echo.
echo =========================================
echo Building Application - ArulKumar
echo =========================================

REM Build with Maven
call mvn clean package -DskipTests

if %errorlevel% equ 0 (
    echo [32mOK Build successful![0m
) else (
    echo [31mX Build failed[0m
    exit /b 1
)

echo.
echo =========================================
echo Building Docker Image - ArulKumar
echo =========================================

REM Build Docker image
docker build -t arulkumar-devops-app:latest .

if %errorlevel% equ 0 (
    echo [32mOK Docker image built successfully![0m
) else (
    echo [31mX Docker build failed[0m
    exit /b 1
)

echo.
echo =========================================
echo Starting Application - ArulKumar
echo =========================================

REM Run Docker container
docker run -d -p 8080:8080 --name arulkumar-devops-container arulkumar-devops-app:latest

if %errorlevel% equ 0 (
    echo [32mOK Application started successfully![0m
    echo.
    echo Access the application at:
    echo   - http://localhost:8080/api/health
    echo   - http://localhost:8080/api/welcome
    echo   - http://localhost:8080/api/info
    echo.
    echo Created by: ArulKumar
) else (
    echo [31mX Failed to start application[0m
    exit /b 1
)

echo =========================================
pause
