package com.dreamtrillions.ems;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

/**
 * Verifies that the application context starts.
 *
 * Runs against an in-memory H2 database so the suite does not require a
 * PostgreSQL instance.
 */
@SpringBootTest
@TestPropertySource(properties = {
        "spring.datasource.url=jdbc:h2:mem:ems-test;DB_CLOSE_DELAY=-1",
        "spring.datasource.driver-class-name=org.h2.Driver",
        "spring.datasource.username=sa",
        "spring.datasource.password=",
        "spring.jpa.hibernate.ddl-auto=create-drop"
})
class EmployeeManagementApplicationTests {

    @Test
    void contextLoads() {
        // Fails automatically if the context cannot be created.
    }
}