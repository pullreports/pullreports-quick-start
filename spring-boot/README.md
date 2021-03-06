# Pull Reports Spring Boot Application

This page contains information about the `spring-boot` sub-project. This sub-project demonstrates how to embed Pull Reports into a [Spring Boot](https://projects.spring.io/spring-boot/) application. In addition to this example application, the Pull Reports [installation](https://www.pullreports.com/docs/latest/install-guide/) documentation contains detailed instructions on how to install Pull Reports into any Spring Boot application. 

See [README](../README.md) for information on installing Pull Reports and starting the `spring-boot` application.

**Contents**
* [Key files](#key-files)
* [Adding a report configuration against your own database](#adding-a-report-configuration-against-your-own-database)

# Key files

The following files within the `spring-boot` project contain important configuration related to Pull Reports installation:

## src/main/resources/pullreports.properties

The [pullreports.properties](src/main/resources/pullreports.properties) file defines the location of the [Pull Reports XML Catalog Files](https://www.pullreports.com/docs/latest/schema/intro.html/) containing the Pull Reports configuration plus the default JNDI `javax.sql.DataSource` to be used when exporting the reports. 

Read about more Pull Reports configuration properties within the [Pull Reports administration](https://www.pullreports.com/docs/latest/admin-guide/) chapter.

## src/main/resources/META-INF/spring-devtools.properties

Because Pull Reports caches the XML Catalog File configuration in the JVM memory, changes to XML Catalog Files are not hot deployed to the running Spring Boot application during development. To enable hot reloading, explicitly add the Pull Reports JAR to the [spring-boot-devtools](https://docs.spring.io/spring-boot/docs/current/reference/html/using-spring-boot.html#using-boot-devtools) `restart` classloader via [spring-devtools.properties](src/main/resources/META-INF/spring-devtools.properties).

## src/main/java/com/pullreports/qs/springboot/Application.java

The [Application class](src/main/java/com/pullreports/qs/springboot/Application.java) contains the
`@ServletComponentScan(basePackages="com.pullreports")` annotation which tells Spring Boot to scan the `com.pullreports` package and automatically register the Pull Reports `ServletContextListener` and `Servlet` on Servlet Container start up.

## src/main/java/com/pullreports/qs/springboot/JndiTomcatServletWebServerFactory

The [JndiTomcatServletWebServerFactory](src/main/java/com/pullreports/qs/springboot/JndiTomcatServletWebServerFactory.java) class overrides the default `ConfigurableServletWebServerFactory` Bean with a Tomcat container which instantiates a JNDI `javax.sql.DataSource` at `java:comp/env/jdbc/petstore-datasource`. This `DataSource` is referenced within [pullreports.properties](src/main/resources/pullreports.properties) as the default `DataSource` for Pull Reports.
 
The `DataSource` connection pool properties are passed to `JndiTomcatServletWebServerFactory` bean via the `@ConfigurationProperties(prefix="datasource")` annotation. See [application.properties](src/main/resources/application.properties) for their values.

## src/main/resources/templates/ad-hoc-creator.ftlh

The FrameMaker file where the [Pull Reports Ad Hoc Creator](https://www.pullreports.com/docs/latest/creator/) is installed. See [AppController.java](src/main/java/com/pullreports/qs/springboot/AppController.java) for the mapping between the `/adHocCreator` URL and `ad-hoc-creator.ftlh`. 

# Adding a report configuration against your own database

Follow these steps to use the `pullreports-quick-start` spring-boot application to develop Pull Reports against your own database schema. Since you will make fundamental changes to the Gradle build configuration, be sure to stop the spring-boot application with `Control+C` before beginning if you previous started it.

## 1) Install your database driver 

If your database is not an H2 database, you must add an appropriate database JDBC driver to the spring boot `runtime` Gradle configuration in order for the embedded container to provide a JNDI datasource to Pull Reports.

For example, to use a PostgreSQL database, add the PostgreSQL driver `runtime` dependency within `build.gradle`:

    dependencies {
        ... 
        runtime 'org.postgresql:postgresql:42.2.9'
        ...
    }
    
## 2) Establish the JNDI DataSource in JndiTomcatServletWebServerFactory

Add a second `ContextResource` within [JndiTomcatServletWebServerFactory.java](src/main/java/com/pullreports/qs/springboot/JndiTomcatServletWebServerFactory.java) component appropriate for your database. To follow the same configuration pattern used for the existing H2 JNDI DataSource, add java bean setters and corresponding properties with `application.properties` for your new database connection. 

For example, to create a connection pool to a PostgreSQL database, add this code to `JndiTomcatServletWebServerFactory`:

```java
...
        
public class JndiTomcatServletWebServerFactory extends TomcatServletWebServerFactory{
    ...
    private String postgresqlUrl;
    ...
    private String postgresqlUrl;
    ...
    private String postgresqlUrl;
    private String postgresqlPassword;
    private String postgresqlUsername;
    
    ...
    public void setPostgresqlPassword(String password){
        this.postgresqlPassword = password;
    }

    public void setPostgresqlUrl(String url){
        this.postgresqlUrl = url;
    }

    public void setPostgresqlUsername(String username){
        this.postgresqlUsername = username;
    }

    ...
    @Override
    protected void postProcessContext(Context context) {
        ...
        context.getNamingResources().addResource(createPostgresqlContextResource());
    }

    ...
    private ContextResource createPostgresqlContextResource() {
        ContextResource resource = new ContextResource();
        resource.setName("jdbc/my-datasource");
        resource.setType(DataSource.class.getName());
        resource.setProperty("driverClassName", "org.postgresql.Driver");
        resource.setProperty("url",postgresqlUrl);
        resource.setProperty("username", postgresqlUsername);
        resource.setProperty("password", postgresqlPassword);
        return resource;
    }
}
```
    
Additionally, add these PostgreSQL connection properties in `application.properties`:

```bash
datasource.postgresql-url=jdbc:postgresql://localhost:5432/dbname
datasource.postgresql-username=your_username
datasource.postgresql-password=your_username
```

## 3) Add your own XML Catalog File

Add a new XML Catalog File (e.g. `my-catalog-file.xml`) to `src/main/resources` and reference it within `src/main/resources/pullreports.properties` like so:

    catalogs=classpath:reports/petstore.xml classpath:my-catalog-file.xml

In the `catalogs` property value, the referenced `classpath:reports/petstore.xml` Pull Reports XML Catalog File is already in existence at `src/main/resources/`. The referenced `classpath:my-catalog-file.xml` Pull Reports XML Catalog File will contain your new report configuration. 

Here is a simple Pull Reports XML Catalog File which reports one column from one database table. Be sure to replace the `schema_name.table_name`, `column_name`, and `java.lang.String` attribute values below with values appropriate for your database schema.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<catalog xmlns="http://www.pullreports.com/catalog-1.6.0" id="my-catalog" name="My First Catalog">
    <report id="my-first-report" name="My First Report">
        <table id="table1" displayName="Table 1" name="schema_name.table_name">
            <column id="column1" name="column_name" displayName="Column 1" paramType="java.lang.String"/>
        </table>
    </report>
</catalog>
```

Reference the Pull Reports documentation, [XML Catalog Files](https://www.pullreports.com/docs/latest/schema/) chapter to learn how to enhance XML Catalog Files.

## 4) Link your JNDI datasource to your new Report

The current [pullreports.properties](src/main/resources/pullreports.properties) file defines a default JNDI DataSource to be used by all Pull Reports via the `jndiDataSource` property. Unfortunately, this JNDI DataSource connects to the embedded H2 database configured within the `database` sub-project. This H2 database will not have the database table and column information you configured within the `my-catalog-file.xml` file in the previous step.

In order to associate the new JNDI DataSource from step 2 with your new report(s), add an additional `jndiDataSource` property to [pullreports.properties](src/main/resources/pullreports.properties) suffixed with your new `<catalog>` `id`. For example, if your new XML Catalog File defines `<catalog id="my-catalog">` as the root element, add this property to `pullreports.properties`:

    jndiDataSource.my-catalog=java:comp/env/jdbc/my-datasource

Reference the Pull Reports documentation, [Administration](https://www.pullreports.com/docs/latest/admin-guide/) chapter to learn about additional configuration properties.
 
## 5) Start the application

Start the application by running `gradlew :spring-boot:bootRun` from the root of the quick start project. Your new report is now available in the Switch Report menu of the Pull Reports Ad Hoc Creator. You may access the new report directly at:

http://localhost:8082/d/adHocCreator?catalogId=my-catalog&reportId=my-first-report

# Testing

This project contains a simple Selenium test, [SpringBootBasicBehaviorTest](src/test/java/com/pullreports/sb/SpringBootBasicBehaviorTest.java), to verify basic application capability.

Before running the test, start the application with `gradlew :spring-boot:bootRun` and install the latest Selenium [ChromeDriver](https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver) executable in your path. Then invoke `gradlew :spring-boot:test` to run the test.
