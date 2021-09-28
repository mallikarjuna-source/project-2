FROM openjdk:8-jdk-alpine as builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN ./mvn clean package


FROM builder
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8090
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
