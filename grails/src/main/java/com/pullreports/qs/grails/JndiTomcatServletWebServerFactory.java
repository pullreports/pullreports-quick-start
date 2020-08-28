package com.pullreports.qs.grails;

import javax.sql.DataSource;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.tomcat.util.descriptor.web.ContextResource;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.embedded.tomcat.TomcatWebServer;

public class JndiTomcatServletWebServerFactory extends TomcatServletWebServerFactory{

    @Override
    protected TomcatWebServer getTomcatWebServer(Tomcat tomcat) {
        tomcat.enableNaming();
        return super.getTomcatWebServer(tomcat);
    }

    @Override
    protected void postProcessContext(Context context) {
        context.getNamingResources().addResource(createH2ContextResource());
    }

    private ContextResource createH2ContextResource() {
        ContextResource resource = new ContextResource();
        resource.setName("jdbc/petstore-datasource");
        resource.setType(DataSource.class.getName());
        resource.setProperty("factory", "org.apache.tomcat.jdbc.pool.DataSourceFactory");
        resource.setProperty("driverClassName", org.h2.Driver.class.getName());
        resource.setProperty("url", "jdbc:h2:tcp://localhost:9092/petstore");
        resource.setProperty("username", "sa");
        resource.setProperty("password", "secret");
        return resource;
    }
}
