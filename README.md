# pullreports-quick-start
An example [Pull Reports](http://www.pullreports.com) ad hoc reporting and web services application.

## Installation

### 1) Clone the Git Repository

Start by cloning this git repository.

`git clone https://github.com/pullreports/pullreports-quick-start.git`

### 2) Obtain the Pull Reports software and license

Email sales@pullreports.com to obtain a copy of the Pull Reports software and temporary license file.

### 3) Install the Pull Reports JAR into your local Maven repository.

Place the `pullreports-x.y.z.jar` file into `$USER_HOME/.m2/repository/com/pullreports/pullreports/x.y.z`.

This will allow the Gradle dependency management tool to find Pull Reports and all of its transitive dependencies.

### 4) Install the pullreports.license file

Place the `pullreports.license` file within the `src/main/resources` directory. This directory is on the root of the WAR classpath. 

### 5) Start Tomcat

From the root of the project, run `./gradlew cargoRunLocal`.


