FROM maven:3-jdk-8 AS package_step

RUN apt-get update && \
  apt-get install -y zsh && \
  apt-get install -y curl && \
  apt-get install -y git && \
  apt-get install -y vim && \
  apt-get install -y jq && \
  apt-get install -y ruby-full && \
  apt-get install -y ca-certificates && \
  update-ca-certificates && \
  apt-get install -y apt-transport-https && \
  apt-get install -y build-essential && \
  chsh -s $(which zsh) 

# install uaac
RUN gem install cf-uaac

# install CF cli
RUN curl -s https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
  echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
  apt-get update && \
  apt-get install -y cf7-cli

# install Oh My Zsh
RUN curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
  sh install.sh && \
  rm install.sh

# disable git ssl verification 
RUN git init && \
  git config --global http.sslVerify false

CMD ["zsh"]
