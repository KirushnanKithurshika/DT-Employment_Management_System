package com.dreamtrillions.ems.api;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Web slice test for {@link SystemController}. Only the web layer is loaded,
 * so no datasource is required.
 */
@WebMvcTest(SystemController.class)
class SystemControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void infoReturnsServiceIdentity() throws Exception {
        mockMvc.perform(get("/api/system/info"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("up"))
                .andExpect(jsonPath("$.apiVersion").value("v1"));
    }
}