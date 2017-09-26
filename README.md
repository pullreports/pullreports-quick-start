# pullreports-quick-start
An example [Pull Reports](https://www.pullreports.com) ad hoc reporting and web services application.

## Installation

### 1) Clone the pullreports-quick-start Git Repository

Start by cloning this git repository.

`git clone https://github.com/pullreports/pullreports-quick-start.git`

### 2) Obtain the Pull Reports software and license

Email sales@pullreports.com to obtain a copy of the Pull Reports software and temporary license file.

The [Pull Reports Installation](https://www.pullreports.com/docs/latest/installation.html) guide details the contents of the Pull Reports software. The JAR and POM files are located within the `dist` directory.

### 3) Install the Pull Reports JAR and POM into your local Maven repository.

The installation of the JAR and POM file into the local Maven repository allows the [Gradle](https://gradle.org) dependency management tool to resolve the Pull Reports JAR and all of its transitive dependencies.

Copy the `pullreports-x.y.z.jar` file into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z` where `x.y.z` is the version of the Pull Reports software.

Copy the `pom.xml` file into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z/pullreports-x.y.z.pom`. It is important that you rename the `pom.xml` file to `pullreports-x.y.z.pom` when you copy the file. Again, `x.y.z` must match the version of the Pull Reports software. 

#### Example Pull Reports 1.0.2 local Maven Repository

    $ ls -1 ~/.m2/repository/com/pullreports/pullreports/1.0.2
    pullreports-1.0.2.jar*
    pullreports-1.0.2.pom*


### 4) Install the pullreports.license file

Place the `pullreports.license` file within the `src/main/resources` directory. This directory will be at the root of the WAR classpath. 

### 5) Start the application

From the root of the project, run `./gradlew appRun`. This command invokes [Gradle Wrapper](https://docs.gradle.org/current/userguide/gradle_wrapper.html), downloads all necessary dependencies, launches an embedded H2 database, and starts Tomcat 8 with the demonstration application via the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin.

Browse to http://localhost:8080 to see the application.

### 6) Making changes

You may make changes to the Pull Reports XML Catalog file at `src/main/resources/reports/petstore.xml` and the changes will be hot deployed to the running application. Any errors will be logged to the terminal window from which `gradlew` was invoked. 

## Add a report for your own database

Follow these steps to use the `pullreports-quick-start` application to develop Pull Reports against your own database schema. Since you will make fundamental changes to the Gradle build configuration, be sure to stop the `pullreports-quick-start` application with `Control+C` before beginning.

### 1) Install your database driver into Gretty

If your database is not an H2 database, you must add your database JDBC driver to the container's classpath via the `gretty` dependency configuration within `build.gradle`. 

For example, to use a PostgreSQL database, add the PostgreSQL driver in `build.gradle`:

    dependencies {
        ... 
        gretty 'org.postgresql:postgresql:9.4.1212'
        ...
    }
    
### 2) Set your database connection parameters within context.xml

Add a JNDI connection pool within `src/main/webapp/META-INF/context.xml` appropriate for your database.

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
    
### 3) Add your own XML Catalog File

Add a new XML Catalog File (e.g. `my-catalog-file.xml`) to `src/main/resources/reports` and reference it within `src/main/resources/pullreports.properties` like so:

    catalogs=classpath:reports/petstore.xml classpath:reports/my-catalog-file.xml

The XML Catalog File must contain at least one `<report>` to be valid. Read the Pull Reports documentation [XML Catalog Files](https://www.pullreports.com/docs/latest/catalog-files.html) chapter to learn how to create XML Catalog Files.

In order to associate the JNDI connection pool you created in the previous step with your new report(s), add a `jndiDataSource` property to `pullreports.properties` suffixed with your new `<catalog>` `id`. For example, if your new XML Catalog File defines a `<catalog id='my-id'>` as the root element, add this property to `pullreports.properties`:

    jndiDataSource.my-id=java:comp/env/jdbc/my-datasource
 
### 4) Start the application

Start the application with `gradlew appRun`. Your new report will be now available within the Switch Report menu of the Pull Reports Ad Hoc Creator.
