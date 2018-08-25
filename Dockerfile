FROM maven:3 AS build

WORKDIR /build

COPY pom.xml .
RUN mkdir -p src/main/java
COPY FakeMain.java src/main/java

RUN mvn package

COPY src ./src

RUN mvn package

FROM openjdk:10.0.1-10-jre

WORKDIR /app
COPY --from=build /build/target/doom-state.jar .

CMD java -jar doom-state.jar
