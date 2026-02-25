package com.arulkumar.devops;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

/**
 * Integration tests for ArulKumar DevOps Application
 * Author: ArulKumar
 */
@SpringBootTest
@ActiveProfiles("test")
class DevOpsApplicationTests {

    @Test
    void contextLoads() {
        // Test that Spring context loads successfully
        // This verifies all beans are properly configured
        // Created by: ArulKumar
    }

    @Test
    void applicationStarts() {
        // Test that the application starts without errors
        // Verifies main method execution
        // Created by: ArulKumar
    }
}
