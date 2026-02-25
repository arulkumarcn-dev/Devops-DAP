package com.arulkumar.devops.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Controller tests for ArulKumar DevOps Application
 * Author: ArulKumar
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
        // Created by: ArulKumar
        mockMvc.perform(get("/api/health"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("UP"))
                .andExpect(jsonPath("$.author").value("ArulKumar"))
                .andExpect(jsonPath("$.application").value("ArulKumar DevOps Assignment"));
    }

    @Test
    void welcomeEndpointShouldReturnWelcomeMessage() throws Exception {
        // Test welcome endpoint returns proper message
        // Verifies the content is correct
        // Created by: ArulKumar
        mockMvc.perform(get("/api/welcome"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Welcome to ArulKumar's DevOps Assignment!"))
                .andExpect(jsonPath("$.author").value("ArulKumar"))
                .andExpect(jsonPath("$.assignment").value("DevOps Sharpened DAP Completion"));
    }

    @Test
    void infoEndpointShouldReturnApplicationInfo() throws Exception {
        // Test info endpoint returns application details
        // Verifies all information is present
        // Created by: ArulKumar
        mockMvc.perform(get("/api/info"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.projectName").value("ArulKumar DevOps Assignment"))
                .andExpect(jsonPath("$.developer").value("ArulKumar"))
                .andExpect(jsonPath("$.version").value("1.0.0"));
    }
}
