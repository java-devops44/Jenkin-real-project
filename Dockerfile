FROM maven as build
WORKDIR /app1
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app1
COPY --from=build /app/target/Uber.jar /app1
EXPOSE 9090
CMD ["java" , "-jar" , "Uber.jar"]