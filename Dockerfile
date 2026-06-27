# STAGE 1

FROM maven:3.9.16-eclipse-temurin-17-alpine AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

# STAGE 2

FROM gcr.io/distroless/java17-debian12

WORKDIR /app

COPY --from=builder /app/target/*.jar ./app.jar

EXPOSE 9090

ENTRYPOINT ["java","-jar","app.jar"]





