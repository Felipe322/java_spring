FROM maven:3.9.5 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean install

RUN mv /app/target/*-SNAPSHOT.jar /app/target/app.jar

FROM openjdk:17-jdk-slim

WORKDIR /app/target/

COPY --from=build /app/target/app.jar .

EXPOSE 8080

CMD ["java","-jar","/app/target/app.jar"]