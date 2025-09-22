# Use official OpenJDK 17 image as base
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the Spring Boot WAR into the container
COPY spring-boot-hello-world-example/target/SpringBootHelloWorldExample.war app.war

# Expose the port the app runs on
EXPOSE 8080

# Run the WAR file
ENTRYPOINT ["java","-jar","app.war"]


