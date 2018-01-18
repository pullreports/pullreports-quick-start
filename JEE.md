# JEE Application

This page contains information about the `jee` sub-project. This sub-project demonstrates how to embed Pull Reports into a Servlet Container.

See [README](README.md) for information on installing Pull Reports and starting the `jee` application.

**Contents**
* [Key files](JEE.md#key-files)
* [Add a Pull Report configuration against your own database](JEE.md#add-a-pull-report-configuration-against-your-own-database)

# Key files

The following files within the `jee` project contain important configuration related to Pull Reports installation:

### build.gradle

Key configuration elements within the [build.gradle](jee/build.gradle) file are the use of the [Gradle `war` plugin](https://docs.gradle.org/current/userguide/war_plugin.html) to build a JEE web application and the use of the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin to serve that application within a local [Tomcat](https://tomcat.apache.org) Servlet Container.

### src/main/resources/pullreports.properties

The [pullreports.properties](src/main/resources/pullreports.properties) file defines the location of the [Pull Reports XML Catalog Files](https://www.pullreports.com/docs/latest/catalog-files.html) containing the Pull Reports configuration plus the default JNDI `javax.sql.DataSource` to be used when exporting the reports. 

Read about more Pull Reports configuration properties within the [Pull Reports administration](https://www.pullreports.com/docs/latest/administration.html) chapter.

### src/main/webapp/META-INF/context.xml

The [context.xml](src/main/webapp/META-INF/context.xml) file is a Tomcat specific configuration file which is read on application start up. This `context.xml` file defines a JNDI `javax.sql.DataSource` at the `java:comp/env/jdbc/petstore-datasource` JNDI path. Note the use of the H2 database connection parameters.

## src/main/webapp/WEB-INF/sitemesh.xml, decorators.xml, and decorators directory

These two XML files and directory within `WEB-INF` demonstrate the use of [SiteMesh](http://wiki.sitemesh.org/wiki/display/sitemesh/Home) to decorate Pull Reports export results. Additionally, the `WEB-INF/web.xml` file contains additional SiteMesh configuration. 

SiteMesh is an optional decoration configuration and only one method of customizing Pull Reports export results. Reference the Pull Reports documentation, [administration](https://www.pullreports.com/docs/latest/administration.html) chapter, to learn more about export decoration.

## src/main/webapp/WEB-INF/content/ad-hoc-creator.jsp

The JSP file where the [Pull Reports Ad Hoc Creator](https://www.pullreports.com/docs/latest/creator.html) is installed.

# Add a Pull Report configuration against your own database

Follow these steps to use the `pullreports-quick-start` JEE application to develop Pull Reports against your own database schema. Since you will make fundamental changes to the Gradle build configuration, be sure to stop the JEE application with `Control+C` before beginning if you previous started it.

## 1) Install your database driver 

If your database is not an H2 database, you must add your database JDBC driver to the servlet container's classpath in order for the container to provide a JNDI datasource to Pull Reports.

Since the `jee` sub-project uses the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin to serve the application, add your database driver to the `gretty` dependency configuration within `jee/build.gradle`. 

For example, to use a PostgreSQL database, add the PostgreSQL driver in `jee/build.gradle`:

    dependencies {
        ... 
        gretty 'org.postgresql:postgresql:9.4.1212'
        ...
    }
    
## 2) Set your database connection parameters within context.xml

Add a JNDI connection pool within `jee/src/main/webapp/META-INF/context.xml` appropriate for your database.

For example, to create a connection pool to a PostgreSQL database, add this `<Resource>` to context.xml:

    <Context path="" swallowOutput="true">
      ...
      <Resource name="jdbc/my-datasource"
                auth="Container"
                type="javax.sql.DataSource"
                username="your_username"
                password="your_password"
                driverClassName="org.postgresql.Driver"
                url="jdbc:postgresql://localhost:5432/dbname"
                maxActive="8"
                maxIdle="4"/>
    </Context>
    
## 3) Add your own XML Catalog File

Add a new XML Catalog File (e.g. `my-catalog-file.xml`) to `jee/src/main/resources` and reference it within `jee/src/main/resources/pullreports.properties` like so:

    catalogs=classpath:reports/petstore.xml classpath:my-catalog-file.xml

In the `catalogs` property value, the referenced `classpath:reports/petstore.xml` Pull Reports XML catalog file is at `src/main/resources/` and included within the `jee` sub-project's classpath via this configuration in `jee/build.gradle`.   

```java
sourceSets {
    main {
        resources {
            srcDir "${project(':').projectDir}/src/main/resources"
        }
    }
}
```

The referenced `classpath:my-catalog-file.xml` Pull Reports XML catalog file will contain your new report configuration 

Here is a simple Pull Reports XML catalog file which reports one column from one database table. Be sure to replace the `schema_name.table_name`, `column_name`, and `java.lang.String` attributes below with values appropriate for your database schema.

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

Reference the Pull Reports documentation, [XML Catalog Files](https://www.pullreports.com/docs/latest/catalog-files.html) chapter to learn how to enhance the XML Catalog File.

## 4) Link your JNDI datasource to your new Report

In order to associate the JNDI DataSource you created in step 2 with your new report(s), add a `jndiDataSource` property to `pullreports.properties` suffixed with your new `<catalog>` `id`. For example, if your new XML Catalog File defines a `<catalog id="my-catalog">` as the root element, add this property to `pullreports.properties`:

    jndiDataSource.my-catalog=java:comp/env/jdbc/my-datasource

Reference the Pull Reports documentation, [Administration](https://www.pullreports.com/docs/latest/administration.html) chapter to learn about additional configuration properties.
 
## 5) Start the application

Start the application by running `gradlew :jee:appRun` from the root of the quick start project. Your new report will be now added to the Switch Report menu of the Pull Reports Ad Hoc Creator. You may access the new report directly at:

http://localhost:8080/adHocCreator?catalogId=my-catalog
