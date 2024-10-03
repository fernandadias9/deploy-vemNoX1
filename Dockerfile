#
# Build stage
#
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Build do Maven SEM testes unitarios
# RUN mvn clean install -DSkipTests=true
RUN mvn clean package -DSkipTests=true

#
# Package stage
#
FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY --from=build app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]