# Build stage
FROM maven:3.8-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
# Copy source code
COPY src ./src
# Copy sample data
COPY sample ./sample
# Build the war
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:9-jre8
# Copy the war from builder stage
COPY --from=builder /app/target/kanban-app-*.war /usr/local/tomcat/webapps/kanban.war
# Copy sample data
COPY --from=builder /app/sample /app/sample
# Set kanban home as system property
ENV CATALINA_OPTS="-Dkanban.home=/app/sample"
# Expose port 8080
EXPOSE 8080
