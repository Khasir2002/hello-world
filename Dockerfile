FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/hello-world-0.0.1-SNAPSHOT.jar hello-world.jar
ENTRYPOINT ["java", "-jar", "hello-world.jar"]