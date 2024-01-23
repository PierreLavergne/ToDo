FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .

COPY src ./src

RUN mvn clean install -DskipTests

FROM eclipse-temurin:17.0.9_9-jdk-jammy

WORKDIR /app

COPY --from=build /app/target/java-api.jar .

CMD ["java", "-jar", "java-api.jar"]
