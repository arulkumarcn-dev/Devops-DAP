package com.arulkumar.devops.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Controller tests for arulkumar DevOps Application
 * Author: arulkumar
 * Developer: arulkumar
 * Assignment: DevOps Sharpened DAP Completion
 */
@SpringBootTest
@AutoConfigureMockMvc
class HealthControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void healthEndpointShouldReturnOk() throws Exception {
        // Test health endpoint returns 200 OK
        // Verifies the endpoint is accessible
        // Created by: arulkumar
        mockMvc.perform(get("/api/health"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("UP"))
                .andExpect(jsonPath("$.author").value("arulkumar"))
                .andExpect(jsonPath("$.developer").value("arulkumar"))
                .andExpect(jsonPath("$.application").value("arulkumar DevOps Assignment"));
    }

    @Test
    void welcomeEndpointShouldReturnWelcomeMessage() throws Exception {
        // Test welcome endpoint returns proper message
        // Verifies the content is correct
        // Created by: arulkumar
        mockMvc.perform(get("/api/welcome"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Welcome to arulkumar's DevOps Assignment!"))
                .andExpect(jsonPath("$.author").value("arulkumar"))
                .andExpect(jsonPath("$.developer").value("arulkumar"))
                .andExpect(jsonPath("$.assignment").value("DevOps Sharpened DAP Completion"));
    }

    @Test
    void infoEndpointShouldReturnApplicationInfo() throws Exception {
        // Test info endpoint returns application details
        // Verifies all information is present
        // Created by: arulkumar
        mockMvc.perform(get("/api/info"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.projectName").value("arulkumar DevOps Assignment"))
                .andExpect(jsonPath("$.developer").value("arulkumar"))
                .andExpect(jsonPath("$.createdBy").value("arulkumar"))
                .andExpect(jsonPath("$.version").value("1.0.0"));
    }
}
