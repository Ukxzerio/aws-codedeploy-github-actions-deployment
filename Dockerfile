# -------- Stage 1: Build --------
FROM maven:3.9.3-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy root pom.xml
COPY pom.xml .

# Copy source code
COPY spring-boot-hello-world-example/src ./src

# Build the WAR file (skip tests)
RUN mvn clean package -DskipTests

# -------- Stage 2: Run --------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
