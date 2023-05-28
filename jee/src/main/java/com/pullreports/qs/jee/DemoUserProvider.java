package com.pullreports.qs.jee;

import com.pullreports.userquery.UserProvider;
import javax.servlet.http.HttpServletRequest;
import java.util.Optional;

public class DemoUserProvider implements UserProvider {

    @Override
    public Optional<String> getUserId(HttpServletRequest request) {
        // Do not use in production. Only for demonstration purposes.
        return Optional.of("demo user");
    }
}
