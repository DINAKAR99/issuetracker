FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the JAR with a generic name
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]