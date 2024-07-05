FROM alpine:latest AS build

# Install necessary packages
RUN apk update && apk add --no-cache \
    openjdk17 \
    maven \
    bash

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean install

RUN mv /app/target/*-SNAPSHOT.jar /app/target/app.jar

FROM alpine:latest

RUN apk update && apk add --no-cache \
    openjdk17-jre

WORKDIR /app/target/

COPY --from=build /app/target/app.jar .

USER appuser

EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]