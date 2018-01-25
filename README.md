# pullreports-quick-start

This repository contains three example [Pull Reports](https://www.pullreports.com) ad hoc reporting and web services applications. Each example uses [Gradle](https://gradle.org) to embed Pull Reports into a different web application framework:

1. JEE: The [`jee`](/jee) sub-project embeds Pull Reports into a JEE servlet container using only the JEE Servlet API.
1. Grails: The [`grails`](/grails) sub-project embeds Pull Reports into a [Grails 3](https://grails.org) application.
1. Spring Boot: The [`spring-boot`](/spring-boot) sub-project embeds Pull Reports into a [Spring Boot](https://projects.spring.io/spring-boot/) application. 

The `database` sub-project contains tasks and configuration to start a local, [H2](http://www.h2database.com) database to support all three application sub-projects.

Pull Reports configuration common to all three application sub-projects resides within the `src` directory of the root project.

## Installation

### 1) Clone the pullreports-quick-start Git Repository

Start by cloning this git repository.

`git clone https://github.com/pullreports/pullreports-quick-start.git`

### 2) Obtain the Pull Reports software and license

Email sales@pullreports.com to obtain a copy of the Pull Reports software and temporary license file.

The [Pull Reports Installation](https://www.pullreports.com/docs/latest/installation.html) guide details the contents of the Pull Reports software. The JAR and POM files you'll need for the next step are located within the `dist` directory of the Pull Reports distribution zip file.

### 3) Install the Pull Reports JAR and POM into your local Maven repository.

Installing the Pull Reports JAR and POM files into the local Maven repository allows [Gradle](https://gradle.org) dependency management to resolve the Pull Reports JAR and all of its transitive dependencies. A local Maven repository is a specially constructed directory structure located within your user home directory.

First, copy the `pullreports-x.y.z.jar` you received from the previous step into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z` where `x.y.z` is the version of the Pull Reports software.

Then, copy the `pom.xml` file into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z/pullreports-x.y.z.pom`. It is important that you rename the `pom.xml` file to `pullreports-x.y.z.pom` when you copy the file. Again, `x.y.z` must match the version of the Pull Reports software. 

#### Example Pull Reports 1.1.3 local Maven Repository

This is what your local maven repository directory structure should look like assuming you have version `1.1.3` of Pull Reports.

    $ ls -1 ~/.m2/repository/com/pullreports/pullreports/1.1.3
    pullreports-1.1.3.jar
    pullreports-1.1.3.pom


### 4) Install the pullreports.license file

Place the `pullreports.license` file within the `src/main/resources` directory. This directory is included at the root of the classpath in each of the three sub-project application deployments. Pull Reports requires a valid license file on the Java Virtual Machine (JVM) classpath when it initializes.

### 5) Start the application(s)

This repository contains Gradle wrapper executables at the root of the repository project - `gradlew` for Linux and `gradlew.bat` for Windows. Executing either wrapper file from a terminal window will download all the Gradle dependencies needed to run the example applications.

Before running the following commands, ensure that the JVM, `java` executable is installed on your computer.

Additionally, each application start command will also start an embedded H2 database configured within the `database` sub-project. This database is used by each application when fulfilling report requests. If you start multiple applications at once, the H2 database will simply restart with each application start.

#### JEE

From the root of the project, run `./gradlew :jee:appRun`. This command starts the JEE Pull Reports application via the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin.

Browse to http://localhost:8080 to see the application.

#### Grails

From the root of the project, run `./gradlew :grails:bootRun`. This command starts the Grails Pull Reports application.

Browse to http://localhost:8081 to see the application.

#### Spring Boot

From the root of the project, run `./gradlew :spring-boot:bootRun`. This command starts the Spring Boot Pull Reports application.

Browse to http://localhost:8082 to see the application.

### 6) Making changes to the example reports

Pull Reports are defined by XML files called Catalog Files because the root XML element is a `<catalog>` grouping one or more `<report>`s. A single XML Catalog File at [src/main/resources/reports/petstore.xml](src/main/resources/reports/petstore.xml) configures the Pull Reports for each example application. Reference the Pull Reports documentation, [XML Catalog Files](https://www.pullreports.com/docs/latest/catalog-files.html) chapter to learn about XML Catalog Files.

You may experiment with Pull Reports XML configuration by making changes to `petstore.xml`. Any changes will be hot deployed to the running application and visible after refreshing your browser. Note that some XML Catalog File changes may require you to clear your browser cache to see the change.

If you make a mistake when changing `petstore.xml`, the error will be logged to the terminal window from which `gradlew` was invoked. 

*By the way...*

The common `petstore.xml` file is included within the classpath of each application sub-project via this Gradle build configuration: 

```groovy
sourceSets {
    main {
        resources {
            srcDir "${project(':').projectDir}/src/main/resources"
        }
    }
}
```

# Additional Information

See the following Guides for more information about how each application works and extending the application for your needs:

* [JEE](jee/README.md)
* [Grails](GRAILS.md)
* [Spring Boot](SB.md)
