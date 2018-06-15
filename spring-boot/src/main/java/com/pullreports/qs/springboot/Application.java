package com.pullreports.qs.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.boot.autoconfigure.web.DispatcherServletAutoConfiguration;
import org.springframework.context.annotation.Bean;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

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
    public ServletRegistrationBean dispatcherServletRegistration() {

        ServletRegistrationBean registration = new ServletRegistrationBean(dispatcherServlet(),"/d/*");
        registration.setName(DispatcherServletAutoConfiguration.DEFAULT_DISPATCHER_SERVLET_REGISTRATION_BEAN_NAME);

        return registration;
    }

    @Bean
    public ServletRegistrationBean itemLookupServletRegistration() {

        ServletRegistrationBean registration = new ServletRegistrationBean(new HttpServlet(){
            @Override
            public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
                response.sendRedirect(request.getServletContext().getContextPath() + "/d/" + request.getServletPath() + "?" + request.getQueryString());
            }
        },"/itemLookup*","/itemLookup");

        return registration;
    }
}
