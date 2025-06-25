# Dockerfile
# This is a test for Dockerfile syntax highlighting and linting.

FROM alpine:latest

LABEL maintainer="Your Name"
LABEL description="Welcome to Rhodium Docker Test"

RUN echo "Welcome to Rhodium" > /app/greeting.txt

WORKDIR /app

CMD ["cat", "greeting.txt"]
