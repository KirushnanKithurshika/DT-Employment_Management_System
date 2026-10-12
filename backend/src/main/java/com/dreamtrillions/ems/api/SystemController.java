package com.dreamtrillions.ems.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class SystemController {

    @GetMapping("/api/system/info")
    public Map<String, String> info() {
        return Map.of(
                "system", "DreamTrillions Employment Management System",
                "apiVersion", "v1",
                "status", "up"
        );
    }
}