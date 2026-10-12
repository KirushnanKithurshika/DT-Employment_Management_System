# ---- build ----
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /workspace

# Dependencies are resolved in their own layer so source edits do not re-download them.
# go-offline is best-effort; package below is the authoritative build step.
COPY pom.xml .
RUN mvn -B -ntp dependency:go-offline || true

COPY src ./src
RUN mvn -B -ntp clean package -DskipTests

# ---- runtime ----
FROM eclipse-temurin:21-jre-alpine AS runtime
WORKDIR /app

# wget/busybox is already present in the alpine image and is used by the compose healthcheck.
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

COPY --from=build --chown=spring:spring /workspace/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]