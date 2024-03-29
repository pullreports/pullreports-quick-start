# Pull Reports JEE Application

This page contains information about the `jee` sub-project. This sub-project demonstrates how to embed Pull Reports into a Servlet Container. In addition to this example application, the Pull Reports [installation](https://www.pullreports.com/docs/latest/install-guide/) documentation contains detailed instructions on how to install Pull Reports into any JEE WAR file. 

See [README](../README.md) for information on installing Pull Reports and starting the `jee` application.

**Contents**
* [Key files](#key-files)
* [Adding a report configuration against your own database](#adding-a-report-configuration-against-your-own-database)

# Key files

The following files within the `jee` project contain important configuration related to Pull Reports installation:

## build.gradle

Key configuration elements within the [build.gradle](build.gradle) file are the use of the [Gradle `war` plugin](https://docs.gradle.org/current/userguide/war_plugin.html) to build a JEE web application and the use of the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin to serve that application within a local [Jetty](https://www.eclipse.org/jetty) Servlet Container.

## src/main/resources/pullreports.properties

The [pullreports.properties](src/main/resources/pullreports.properties) file defines the location of the [Pull Reports XML Catalog Files](https://www.pullreports.com/docs/latest/schema/intro.html) containing the Pull Reports configuration plus the default JNDI `javax.sql.DataSource` to be used when exporting the reports. 

Read about more Pull Reports configuration properties within the [Pull Reports administration](https://www.pullreports.com/docs/latest/admin-guide/) chapter.

## jetty/jetty.xml

The [jetty.xml](jetty/jetty.xml) file is a Jetty specific configuration file read on start up. This `jetty.xml` file defines a JNDI `javax.sql.DataSource` at the `java:comp/env/jdbc/petstore-datasource` JNDI path. Note the use of the H2 database connection parameters.

## src/main/webapp/WEB-INF/sitemesh.xml, decorators.xml, and decorators directory

These two XML files and directory within [WEB-INF](src/main/webapp/WEB-INF) demonstrate the use of [SiteMesh](http://wiki.sitemesh.org/wiki/display/sitemesh/Home) to decorate Pull Reports export results. Note that the JEE [web.xml](src/main/webapp/WEB-INF/web.xml) file contains additional SiteMesh configuration. 

SiteMesh is an optional decoration configuration and only one method of customizing Pull Reports export results. Reference the Pull Reports documentation, [administration](https://www.pullreports.com/docs/latest/admin-guide/) chapter, to learn more about export decoration.

## src/main/webapp/WEB-INF/content/ad-hoc-creator.jsp

The JSP file where the [Pull Reports Ad Hoc Creator](https://www.pullreports.com/docs/latest/creator/) is installed.

# Adding a report configuration against your own database

Follow these steps to use the `pullreports-quick-start` JEE application to develop Pull Reports against your own database schema. Since you will make fundamental changes to the Gradle build configuration, be sure to stop the JEE application with `Control+C` before beginning if you previous started it.

## 1) Install your database driver 

If your database is not an H2 database, you must add an appropriate JDBC driver to the Servlet Container's classpath in order for the container to provide a JNDI datasource to Pull Reports.

Since the `jee` sub-project uses the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin to serve the application, add your database driver to the `gretty` dependency configuration within `build.gradle`. 

For example, to use a PostgreSQL database, add the PostgreSQL driver in `build.gradle`:

    dependencies {
        ... 
        gretty 'org.postgresql:postgresql:42.2.20'
        ...
    }
    
## 2) Set your database connection parameters within jetty.xml

Add a JNDI connection pool within `jetty/jetty.xml` appropriate for your database.

For example, to create a connection pool to a PostgreSQL database, add this JNDI resource definition to `jetty.xml`:

```xml
<Configure id="Server" class="org.eclipse.jetty.server.Server">
  ...
  <New id="MyDatasource" class="org.eclipse.jetty.plus.jndi.Resource">
      <Arg></Arg>
      <Arg>jdbc/my-datasource</Arg>
      <Arg>
          <New class="org.apache.commons.dbcp.BasicDataSource">
              <Set name="driverClassName">org.postgresql.Driver</Set>
              <Set name="url">jdbc:postgresql://localhost:5432/dbname</Set>
              <Set name="username">your_username</Set>
              <Set name="password">your_password</Set>
          </New>
      </Arg>
  </New>
</Configure>
```
    
## 3) Add your own XML Catalog File

Add a new XML Catalog File (e.g. `my-catalog-file.xml`) to `src/main/resources` and reference it within `src/main/resources/pullreports.properties` like so:

    catalogs=classpath:reports/petstore.xml classpath:my-catalog-file.xml

In the `catalogs` property value, the referenced `classpath:reports/petstore.xml` Pull Reports XML Catalog File is already in existence at `src/main/resources/`. The referenced `classpath:my-catalog-file.xml` Pull Reports XML Catalog File will contain your new report configuration. 

Here is a simple Pull Reports XML Catalog File which reports one column from one database table. Be sure to replace the `schema_name.table_name`, `column_name`, and `java.lang.String` attribute values below with values appropriate for your database schema.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<catalog xmlns="http://www.pullreports.com/catalog-1.5.0" id="my-catalog" name="My First Catalog">
    <report id="my-first-report" name="My First Report">
        <table id="table1" displayName="Table 1" name="schema_name.table_name">
            <column id="column1" name="column_name" displayName="Column 1" paramType="java.lang.String"/>
        </table>
    </report>
</catalog>
```

Reference the Pull Reports documentation, [XML Catalog Files](https://www.pullreports.com/docs/latest/schema/) chapter to learn how to enhance XML Catalog Files.

## 4) Link your JNDI datasource to your new Report

The current `src/main/resources/pullreports.properties` file defines a default JNDI DataSource to be used by all Pull Reports via the `jndiDataSource` property. Unfortunately, this JNDI DataSource connects to the embedded H2 database configured within the `database` sub-project. This H2 database will not have the database table and column information you configured within the `my-catalog-file.xml` file in the previous step.

In order to associate the new JNDI DataSource from step 2 with your new report(s), add an additional `jndiDataSource` property to `src/main/resources/pullreports.properties` suffixed with your new `<catalog>` `id`. For example, if your new XML Catalog File defines `<catalog id="my-catalog">` as the root element, add this property to `pullreports.properties`:

    jndiDataSource.my-catalog=java:comp/env/jdbc/my-datasource

Reference the Pull Reports documentation, [Administration](https://www.pullreports.com/docs/latest/admin-guide/) chapter to learn about additional configuration properties.
 
## 5) Start the application

Start the application by running `./gradlew :jee:appRun` from the root of the quick start project. Your new report is now available in the Switch Report menu of the Pull Reports Ad Hoc Creator. You may access the new report directly at:

http://localhost:8080/adHocCreator?catalogId=my-catalog&reportId=my-first-report

# Testing

This project contains a simple Selenium test, [JeeBasicBehaviorTest](src/test/java/com/pullreports/jee/JeeBasicBehaviorTest.java), to verify basic application capability.

Before running the test, start the application with `gradlew :jee:appRun` and install the appropriate [ChromeDriver](https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver) executable in your path. Then invoke `gradlew :jee:test` to run the test.
