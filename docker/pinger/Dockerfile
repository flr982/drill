# Base image
FROM ubuntu:20.04

# Required installation
RUN apt-get update && apt-get -y install iputils-ping

ENTRYPOINT [ "ping" ]
CMD [ "www.google.com" ]
