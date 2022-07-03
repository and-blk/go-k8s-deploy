FROM golang:1.18.3
ARG TOKENARG
ENV TOKEN ${TOKENARG}
# RUN echo "192.168.0.100 gitlab.local.com" >> /etc/hosts
RUN curl -k --output "artifacts.zip" --header "PRIVATE-TOKEN: ${TOKEN}" \
        https://gitlab.local.com/api/v4/projects/2/jobs/artifacts/main/download?job=build 
RUN apt update \
    && apt install fastjar -y \
    && apt-get clean \
    && jar -xvf artifacts.zip \
    && chmod +x ./go_source/main

ENTRYPOINT ["./go_source/main"]