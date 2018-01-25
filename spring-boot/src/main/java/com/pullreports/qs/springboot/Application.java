package com.pullreports.qs.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan(basePackages="com.pullreports")
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    /*
    @Bean
    @ConfigurationProperties(prefix="datasource")
    public EmbeddedServletContainerFactory servletContainer() {
        return new TomcatEmbeddedServletContainerFactory() {
            
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
            protected TomcatEmbeddedServletContainer getTomcatEmbeddedServletContainer(Tomcat tomcat) {
                tomcat.enableNaming();
                return super.getTomcatEmbeddedServletContainer(tomcat);
            }

            @Override
            protected void postProcessContext(Context context) {
                context.getNamingResources().addResource(createH2ContextResource());
            }

            private ContextResource createH2ContextResource() {
                ContextResource resource = new ContextResource();
                resource.setName("jdbc/petstore-datasource");
                resource.setType(DataSource.class.getName());
                resource.setProperty("driverClassName", "org.h2.Driver");
                resource.setProperty("url",h2Url);
                resource.setProperty("username", h2Username);
                resource.setProperty("password", h2Password);
                return resource;
            }
        };
    }
    */
}