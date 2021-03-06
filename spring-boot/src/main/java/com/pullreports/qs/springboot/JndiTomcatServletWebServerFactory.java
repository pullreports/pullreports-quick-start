package com.pullreports.qs.springboot;

import javax.sql.DataSource;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.tomcat.util.descriptor.web.ContextResource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.embedded.tomcat.TomcatWebServer;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix="datasource")
public class JndiTomcatServletWebServerFactory extends TomcatServletWebServerFactory {

    private String h2Url;
    private String h2Password;
    private String h2Username;
    
    public void setH2Password(String password){
        this.h2Password = password;
    }

    public void setH2Url(String url){
        this.h2Url = url;
    }

    public void setH2Username(String username){
        this.h2Username = username;
    }

    @Override
    protected TomcatWebServer getTomcatWebServer(Tomcat tomcat) {
        tomcat.enableNaming();
        return super.getTomcatWebServer(tomcat);
    }

    @Override
    protected void postProcessContext(Context context) {
        context.getNamingResources().addResource(createH2ContextResource());
        context.addWelcomeFile("d/");

    }

    private ContextResource createH2ContextResource() {
        ContextResource resource = new ContextResource();
        resource.setName("jdbc/petstore-datasource");
        resource.setType(DataSource.class.getName());
        resource.setProperty("driverClassName", org.h2.Driver.class.getName());
        resource.setProperty("url",h2Url);
        resource.setProperty("username", h2Username);
        resource.setProperty("password", h2Password);
        return resource;
    }
}
