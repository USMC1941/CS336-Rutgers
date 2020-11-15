plugins {
   java
   war
}

group = "com.cs336"
version = "1.0-SNAPSHOT"

repositories {
   mavenCentral()
   jcenter()
}

java {
   sourceCompatibility = JavaVersion.VERSION_1_8
   targetCompatibility = JavaVersion.VERSION_1_8
}

dependencies {
   // https://search.maven.org/artifact/mysql/mysql-connector-java/8.0.22/jar
   implementation("mysql:mysql-connector-java:8.0.22")

   // https://search.maven.org/artifact/javax.servlet.jsp/javax.servlet.jsp-api/2.3.3/jar
   implementation("javax.servlet.jsp:javax.servlet.jsp-api:2.3.3")

   //https://search.maven.org/artifact/javax.servlet/javax.servlet-api/4.0.1/jar
   implementation("javax.servlet:javax.servlet-api:4.0.1")
}
