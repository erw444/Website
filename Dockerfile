FROM openjdk:8-jdk-alpine
RUN addgroup -S webDev && adduser -S webDev -G webDev
USER webDev:webDev
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]