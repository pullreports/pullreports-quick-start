package com.pullreports.demo;

import com.pullreports.userquery.UserProvider;
import jakarta.servlet.http.HttpServletRequest;

import java.util.Optional;

public class DemoUserProvider implements UserProvider {

    @Override
    public Optional<String> getUserId(HttpServletRequest request) {
        // Do not use in production. Only for demonstration purposes.
        return Optional.of("demo user");
    }
}
