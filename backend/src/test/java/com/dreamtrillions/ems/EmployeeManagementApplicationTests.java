package com.dreamtrillions.ems;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = {
        "spring.datasource.url=jdbc:h2:mem:ems-test;DB_CLOSE_DELAY=-1",
        "spring.datasource.driver-class-name=org.h2.Driver",
        "spring.datasource.username=sa",
        "spring.datasource.password=",
        "spring.jpa.hibernate.ddl-auto=create-drop"
})
class EmployeeManagementApplicationTests {

    @Autowired
    private SystemControllerFixture fixture;

    /** Proves the application context loads and the web layer is wired. */
    @Test
    void contextLoads() {
        // Autowiring SystemControllerFixture fails the test if the context cannot start.
    }

    /** Minimal helper so the test asserts on real application wiring. */
    static class SystemControllerFixture {
        SystemControllerFixture(com.dreamtrillions.ems.api.SystemController controller) {
            if (controller == null) {
                throw new IllegalStateException("SystemController was not registered");
            }
        }
    }
}