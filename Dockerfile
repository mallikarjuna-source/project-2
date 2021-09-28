FROM openjdk:8 AS BUILD_IMAGE
ENV APP_HOME=/root/dev/myapp/
RUN mkdir -p $APP_HOME/src/main/java
WORKDIR $APP_HOME
COPY /opt/gradle/gradle-6.4.1/bin/gradle gradlew.bat $APP_HOME
COPY gradle $APP_HOME/gradle
# download dependencies
RUN ./gradlew build -x :bootRepackage -x test --continue
COPY . .
RUN ./gradlew build

FROM openjdk:8-jre
WORKDIR /root/
COPY --from=BUILD_IMAGE /root/dev/myapp/build/libs/myapp.jar .
EXPOSE 8090
CMD ["java","-jar","myapp.jar"]
