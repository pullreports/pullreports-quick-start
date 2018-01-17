# pullreports-quick-start

This repository contains three example [Pull Reports](https://www.pullreports.com) ad hoc reporting and web services applications.

The applications demonstrate how to embed Pull Reports into three different web frameworks:

1. JEE: The `jee` sub-project is a Java EE application which demonstrates how to embed Pull Reports into a JEE servlet container without any additional deployment framework.
1. Grails: The `grails` sub-project embeds Pull Reports into a [Grails 3](https://grails.org) application.
1. Spring Boot: The `spring-boot` sub-project embeds Pull Reports into a [Spring Boot](https://projects.spring.io/spring-boot/) application. 

The `database` sub-project contains tasks and configuration to start a local, [H2](http://www.h2database.com) database to support all three application sub-projects.

Pull Reports configuration common to all three application sub-projects resides within the `src` directory of the root project.

## Installation

### 1) Clone the pullreports-quick-start Git Repository

Start by cloning this git repository.

`git clone https://github.com/pullreports/pullreports-quick-start.git`

### 2) Obtain the Pull Reports software and license

Email sales@pullreports.com to obtain a copy of the Pull Reports software and temporary license file.

The [Pull Reports Installation](https://www.pullreports.com/docs/latest/installation.html) guide details the contents of the Pull Reports software. The JAR and POM files are located within the `dist` directory.

### 3) Install the Pull Reports JAR and POM into your local Maven repository.

Installing the Pull Reports JAR and POM file into the local Maven repository allows [Gradle](https://gradle.org) dependency management to resolve the Pull Reports JAR and all of its transitive dependencies.

Copy the `pullreports-x.y.z.jar` you received from the previous step into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z` where `x.y.z` is the version of the Pull Reports software.

Copy the `pom.xml` file into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z/pullreports-x.y.z.pom`. It is important that you rename the `pom.xml` file to `pullreports-x.y.z.pom` when you copy the file. Again, `x.y.z` must match the version of the Pull Reports software. 

#### Example Pull Reports 1.1.3 local Maven Repository

    $ ls -1 ~/.m2/repository/com/pullreports/pullreports/1.1.3
    pullreports-1.1.3.jar*
    pullreports-1.1.3.pom*


### 4) Install the pullreports.license file

Place the `pullreports.license` file within the `src/main/resources` directory. This directory is included at the root of the classpath in each of the three sub-project application deployments. 

### 5) Start the application(s)

#### JEE

From the root of the project, run `./gradlew :jee:appRun`. This command starts the embedded H2 database from the `database` sub-project and then starts the JEE Pull Reports application via the [Gretty Gradle](http://akhikhl.github.io/gretty-doc/index.html) plugin.

Browse to http://localhost:8080 to see the application.

#### Grails

From the root of the project, run `./gradlew :grails:bootRun`. This command starts the embedded H2 database from the `database` sub-project and then starts the Grails Pull Reports application.

Browse to http://localhost:8081 to see the application.

#### Spring Boot

From the root of the project, run `./gradlew :spring-boot:bootRun`. This command starts the embedded H2 database from the `database` sub-project and then starts the Spring Boot Pull Reports application.

Browse to http://localhost:8082 to see the application.

### 6) Making changes

You may make changes to the Pull Reports XML Catalog file at `src/main/resources/reports/petstore.xml` and the changes will be hot deployed to the running application. Any errors will be logged to the terminal window from which `gradlew` was invoked. 

# Additional Information

See the following Guides for more information about extending the three example applications for your needs:

* [JEE](JEE.md)