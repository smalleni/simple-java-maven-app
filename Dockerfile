FROM maven:3-openjdk-8 AS build

ENV MAVEN_OPTS="-XX:+TieredCompilation"

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app

COPY src /usr/src/app/src

RUN mvn clean install

FROM openjdk:11

COPY --from=build /usr/src/app/target /opt/target

WORKDIR /opt/target

ENTRYPOINT ["java","-jar","my-app-1.0-SNAPSHOT.jar"]
