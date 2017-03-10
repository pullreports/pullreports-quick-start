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

#### Example Pull Reports 0.9.0 local Maven Repository

    $ ls -1 ~/.m2/repository/com/pullreports/pullreports/0.9.0
    pullreports-0.9.0.jar*
    pullreports-0.9.0.pom*


### 4) Install the pullreports.license file

Place the `pullreports.license` file within the `src/main/resources` directory. This directory will be at the root of the WAR classpath. 

### 5) Start the application

From the root of the project, run `./gradlew cargoRunLocal`. This command invokes [Gradle Wrapper](https://docs.gradle.org/current/userguide/gradle_wrapper.html), downloads all necessary dependencies, launches an embedded H2 database, and starts Tomcat with the demonstration application.

Browse to http://localhost:8080 to see the application.
