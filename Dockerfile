# Stage 1: Build the JAR using Maven
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app

# Copy only pom.xml first (to cache dependencies)
COPY spring-boot-hello-world-example/pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY spring-boot-hello-world-example/src ./src

# Build the jar
RUN mvn clean package -DskipTests

# Stage 2: Run the Spring Boot app
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

