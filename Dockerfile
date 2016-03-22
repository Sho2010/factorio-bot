FROM ruby:onbuild
MAINTAINER Sho2010

ENV SLACK_TOKEN="" \
    DOCKER_CLOUD_API_KEY="" \
    DOCKER_CLOUD_USER=""

CMD ["slappy", "start"]
