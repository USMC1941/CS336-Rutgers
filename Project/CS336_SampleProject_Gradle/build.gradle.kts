plugins {
    war
}

group = "com.cs336"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}

dependencies {
    // https://search.maven.org/artifact/mysql/mysql-connector-java
    implementation("mysql:mysql-connector-java:8.0.26")

    // https://search.maven.org/artifact/javax.servlet.jsp/javax.servlet.jsp-api
    implementation("javax.servlet.jsp:javax.servlet.jsp-api:2.3.3")

    // https://search.maven.org/artifact/javax.servlet/javax.servlet-api/
    implementation("javax.servlet:javax.servlet-api:4.0.1")
}
