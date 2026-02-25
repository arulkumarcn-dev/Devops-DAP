package com.arulkumar.devops.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Health Check Controller
 * Author: arulkumar
 * Developer: arulkumar
 * Assignment: DevOps Sharpened DAP Completion
 */
@RestController
@RequestMapping("/api")
public class HealthController {

    @GetMapping("/health")
    public Map<String, Object> health() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("application", "arulkumar DevOps Assignment");
        response.put("author", "arulkumar");
        response.put("developer", "arulkumar");
        response.put("timestamp", LocalDateTime.now().toString());
        response.put("message", "Application is running successfully!");
        return response;
    }

    @GetMapping("/welcome")
    public Map<String, Object> welcome() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Welcome to arulkumar's DevOps Assignment!");
        response.put("assignment", "DevOps Sharpened DAP Completion");
        response.put("author", "arulkumar");
        response.put("developer", "arulkumar");
        response.put("features", new String[]{
            "Jenkins Pipeline Integration",
            "Docker Containerization",
            "AWS ECR & ECS Deployment",
            "AWS CodePipeline CI/CD",
            "CloudFormation Infrastructure as Code"
        });
        return response;
    }

    @GetMapping("/info")
    public Map<String, Object> info() {
        Map<String, Object> response = new HashMap<>();
        response.put("projectName", "arulkumar DevOps Assignment");
        response.put("developer", "arulkumar");
        response.put("createdBy", "arulkumar");
        response.put("version", "1.0.0");
        response.put("description", "SpringBoot application with complete CI/CD pipeline");
        response.put("technologies", new String[]{
            "Spring Boot 3.2.0",
            "Java 17",
            "Docker",
            "Jenkins",
            "AWS ECR",
            "AWS ECS",
            "AWS CodePipeline",
            "CloudFormation"
        });
        return response;
    }
}
