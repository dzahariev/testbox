FROM alpine:3 AS package_step

RUN apk update && \
  apk add zsh && \
  apk add curl && \
  apk add git && \
  apk add vim && \
  apk add postgresql-client && \
  apk add jq && \
  apk add build-base  && \
  apk add ruby-dev 

# install uaac
RUN gem install cf-uaac

# install CF cli
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v7&source=github" | tar -zx && \
  mv ./cf7 /usr/bin/ && \
  mv ./cf /usr/bin/

# install Oh My Zsh
RUN curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
  sh install.sh && \
  rm install.sh

CMD ["zsh"]
