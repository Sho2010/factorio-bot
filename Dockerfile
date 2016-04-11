FROM ruby:onbuild
MAINTAINER Sho2010

ENV SLACK_TOKEN="" \
    DOCKERCLOUD_APIKEY="" \
    DOCKERCLOUD_USER=""

CMD ["slappy", "start"]
