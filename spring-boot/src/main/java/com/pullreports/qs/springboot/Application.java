package com.pullreports.qs.springboot;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.servlet.DispatcherServletAutoConfiguration;
import org.springframework.boot.autoconfigure.web.servlet.DispatcherServletRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.DispatcherServlet;

@SpringBootApplication
@ServletComponentScan(basePackages="com.pullreports")
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public DispatcherServlet dispatcherServlet() {
        return new DispatcherServlet();
    }
 
    @Bean
    public DispatcherServletRegistrationBean dispatcherServletRegistration() {

        DispatcherServletRegistrationBean registration = 
                new DispatcherServletRegistrationBean(dispatcherServlet(),"/d/*");
        registration.setName(DispatcherServletAutoConfiguration.DEFAULT_DISPATCHER_SERVLET_REGISTRATION_BEAN_NAME);

        return registration;
    }

    @Bean
    public ServletRegistrationBean<HttpServlet> itemLookupServletRegistration() {

        ServletRegistrationBean<HttpServlet> registration = new ServletRegistrationBean<>(
                new HttpServlet(){
            private static final long serialVersionUID = 7498573458734571L;

            @Override
            public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
                response.sendRedirect(request.getServletContext().getContextPath() + "/d" + request.getServletPath() + "?" + request.getQueryString());
            }
        },"/itemLookup/*","/itemLookup");

        return registration;
    }
}
