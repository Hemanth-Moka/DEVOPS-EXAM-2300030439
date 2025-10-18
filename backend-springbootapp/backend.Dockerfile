# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /30439-exam

COPY mvnw .          
COPY .mvn/ .mvn
COPY pom.xml ./

RUN chmod +x mvnw
COPY src ./src

RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /30439-exam
COPY --from=builder /30439-exam/target/*.jar 30439-exam.jar

EXPOSE 2000

ENTRYPOINT ["java", "-jar", "30439-exam.jar"]