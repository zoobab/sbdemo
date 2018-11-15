FROM maven
RUN mkdir -pv /app
COPY . /app
WORKDIR /app
RUN mvn install
ENTRYPOINT ["/app/target/myproject-0.0.1-SNAPSHOT.jar"]
