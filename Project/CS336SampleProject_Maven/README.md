# CS336 Sample Project - Maven

This is a port of the CS336 sample project that uses Apache Maven to create the output `.war` file.

## Prerequites

-  Java 8+
-  [Apache Maven](https://maven.apache.org/)
-  [Apache Tomcat](http://tomcat.apache.org/)
-  MySQL Workbench
-  MySQL Server

## Instructions

1. Download and navigate into the project.
2. Execute the SQL file in the `Resources` directory as the instructions states in MySQL Workbench.
3. Change the JDBC Connection String, database username and database password in [`ApplictionDB.java`](src/main/java/com/cs336/pkg/ApplicationDB.java).
4. To generate the `.war`, simply run

   ```sh
   mvn clean install
   ```

5. The `.war` file would be in the newly created `target` directory.
