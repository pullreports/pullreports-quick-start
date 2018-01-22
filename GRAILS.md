# Pull Reports Grails Application

This page contains information about the `grails` sub-project. This sub-project demonstrates how to embed Pull Reports into a [Grails](https://grails.org) application. In addition to this example application, the Pull Reports [installation](https://www.pullreports.com/docs/latest/installation.html) documentation contains detailed instructions on how to install Pull Reports into any Grails application. 

See [README](README.md) for information on installing Pull Reports and starting the `grails` application.

**Contents**
* [Key files](GRAILS.md#key-files)
* [Adding a report configuration against your own database](GRAILS.md#adding-a-report-configuration-against-your-own-database)

# Key files

The following files within the `grails` sub-project contain important configuration related to Pull Reports installation:

## ./build-ext.gradle

The [build-ext.gradle](grails/build-ext.gradle) file extends the Gradle build with configuration necessary for Pull Reports. Since Grails ships with a Gradle build file, keeping additional configuration within a separate Gradle build file makes Grails upgrades easier. 

## src/main/resources/pullreports.properties

The [pullreports.properties](grails/src/main/resources/pullreports.properties) file defines the location of the [Pull Reports XML Catalog Files](https://www.pullreports.com/docs/latest/catalog-files.html) containing the Pull Reports configuration plus the default JNDI `javax.sql.DataSource` to be used when exporting the reports. 

Additionally, Grails requires that the `static.resource.prefix=/static` property be set in order to correctly serve Pull Reports static resources in the `html` and `geojson` export formats.

Read about more Pull Reports configuration properties within the [Pull Reports administration](https://www.pullreports.com/docs/latest/administration.html) chapter.

## src/main/resources/META-INF/spring-devtools.properties

Grails uses [spring-loaded](https://github.com/spring-projects/spring-loaded) to hot deploy changes to class files during development. Because Pull Reports deployed within a Servlet Container caches Pull Reports XML Catalog File state in the JVM memory, changes to Catalog Files are not refreshed by `spring-loaded`.

In order to hot reload changes to Pull Reports XML Catalog Files, the `grails` sub-project uses [spring-boot-devtools](https://docs.spring.io/spring-boot/docs/current/reference/html/using-boot-devtools.html) for hot reloading instead of `spring-loaded`. In order to enable `spring-boot-devtools`, it is first declared as a `runtime` dependency in [build-ext.gradle](grails/build-ext.gradle).  Then `spring-loaded` is disabled by the `grails.agent.enabled=false` property in [application-development.yml](grails/grails-app/conf/application-development.yml). Finally, to enable hot reloading of XML Catalog Files, explicitly add the Pull Reports JAR to the spring-boot-devtools `restart` classloader via [spring-devtools.properties](grails/src/main/resources/META-INF/spring-devtools.properties).

## grails-app/conf/spring/resources.groovy

The [resources.groovy](grails/grails-app/conf/spring/resources.groovy) file contains three Spring beans necessary for Pull Reports installation.

### tomcatEmbeddedServletContainerFactory

This bean overrides the default `TomcatEmbeddedServletContainerFactory` used by Grails for development deployment with the [JndiTomcatEmbeddedServletContainerFactory] (grails/src/main/java/com/pullreports/qs/grails/JndiTomcatEmbeddedServletContainerFactory.java) class.  `JndiTomcatEmbeddedServletContainerFactory` instantiates a JNDI `javax.sql.DataSource` at `java:comp/env/jdbc/petstore-datasource`. This `DataSource` is referenced within [pullreports.properties](grails/src/main/resources/pullreports.properties) as the default `DataSource` for Pull Reports.

### `pullreportsListener` and `pullreportsListener`

These two Spring beans register the Pull Reports `ServletContextListener` and `Servlet` respectively on Servlet Container start up.

## grails-app/views/ad-hoc-creator.gsp

The GSP file where the [Pull Reports Ad Hoc Creator](https://www.pullreports.com/docs/latest/creator.html) is installed. See [UrlMappings.groovy](grails/grails-app/controllers/grails/UrlMappings.groovy) for the mapping between the `/adHocCreator` URL and [`ad-hoc-creator.gsp`](grails/grails-app/views/ad-hoc-creator.gsp). 

# Adding a report configuration against your own database

Follow these steps to use the `pullreports-quick-start` grails application to develop Pull Reports against your own database schema. Since you will make fundamental changes to the Gradle build configuration, be sure to stop the grails application with `Control+C` before beginning if you previous started it.

## 1) Install your database driver 

If your database is not an H2 database, you must add an appropriate database JDBC driver for your database to the `compile` Gradle configuration in order for the embedded container to provide a JNDI datasource to Pull Reports.

For example, to use a PostgreSQL database, add the PostgreSQL driver `compile` dependency within `grails/build-ext.gradle`:

    dependencies {
        ... 
        compile 'org.postgresql:postgresql:42.2.0'
        ...
    }
    
## 2) Establish the JNDI DataSource in JndiTomcatEmbeddedServletContainerFactory.java

Add a second `ContextResource` within the [JndiTomcatEmbeddedServletContainerFactory.java](grails/src/main/java/com/pullreports/qs/grails/JndiTomcatEmbeddedServletContainerFactory.java) `TomcatEmbeddedServletContainer` bean appropriate for your database. 

For example, to create a connection pool to a PostgreSQL database, add this code to the `JndiTomcatEmbeddedServletContainerFactory` bean:

```java
...
public class JndiTomcatEmbeddedServletContainerFactory extends TomcatEmbeddedServletContainerFactory{

    @Override
    protected void postProcessContext(Context context) {
        ...
        context.getNamingResources().addResource(createPostgresContextResource());
    }
    
    ...

    private ContextResource createPostgresContextResource() {
        ContextResource resource = new ContextResource();
        resource.setName("jdbc/my-datasource");
        resource.setType(DataSource.class.getName());
        resource.setProperty("factory", "org.apache.tomcat.jdbc.pool.DataSourceFactory");
        resource.setProperty("driverClassName", org.postgresql.Driver.class.getName());
        resource.setProperty("url", "jdbc:postgresql://localhost:5432/dbname");
        resource.setProperty("username", "your_username");
        resource.setProperty("password", "your_password");
        return resource;
    }
}
```
    
## 3) Add your own XML Catalog File

Add a new XML Catalog File (e.g. `my-catalog-file.xml`) to `grails/src/main/resources` and reference it within `grails/src/main/resources/pullreports.properties` like so:

    catalogs=classpath:reports/petstore.xml classpath:my-catalog-file.xml

In the `catalogs` property value, the referenced `classpath:reports/petstore.xml` Pull Reports XML Catalog File is already in existence at `src/main/resources/`. The referenced `classpath:my-catalog-file.xml` Pull Reports XML Catalog File will contain your new report configuration. 

Here is a simple Pull Reports XML Catalog File which reports one column from one database table. Be sure to replace the `schema_name.table_name`, `column_name`, and `java.lang.String` attribute values below with values appropriate for your database schema.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<catalog xmlns="http://www.pullreports.com/catalog-1.3.0" id="my-catalog" name="My First Catalog">
    <report id="my-first-report" name="My First Report">
        <table id="table1" displayName="Table 1" name="schema_name.table_name">
            <column id="column1" name="column_name" displayName="Column 1" paramType="java.lang.String"/>
        </table>
    </report>
</catalog>
```

Reference the Pull Reports documentation, [XML Catalog Files](https://www.pullreports.com/docs/latest/catalog-files.html) chapter to learn how to enhance XML Catalog Files.

## 4) Link your JNDI datasource to your new Report

The current [pullreports.properties](grails/src/main/resources/pullreports.properties) file defines a default JNDI DataSource to be used by all Pull Reports via the `jndiDataSource` property. Unfortunately, this JNDI DataSource connects to the embedded H2 database configured within the `database` sub-project. This H2 database will not have the database table and column information you configured within the `my-catalog-file.xml` file in the previous step.

In order to associate the new JNDI DataSource from step 2 with your new report(s), add an additional `jndiDataSource` property to [pullreports.properties](grails/src/main/resources/pullreports.properties) suffixed with your new `<catalog>` `id`. For example, if your new XML Catalog File defines `<catalog id="my-catalog">` as the root element, add this property to `pullreports.properties`:

    jndiDataSource.my-catalog=java:comp/env/jdbc/my-datasource

Reference the Pull Reports documentation, [Administration](https://www.pullreports.com/docs/latest/administration.html) chapter to learn about additional configuration properties.
 
## 5) Start the application

Start the application by running `./gradlew :grails:bootRun` from the root of the quick start project. Your new report is now available in the Switch Report menu of the Pull Reports Ad Hoc Creator. You may access the new report directly at:

http://localhost:8081/adHocCreator?catalogId=my-catalog&reportId=my-first-report
