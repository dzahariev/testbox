FROM maven:3-jdk-8 AS package_step

RUN apt-get update && \
  apt-get install -y zsh && \
  apt-get install -y curl && \
  apt-get install -y unzip && \
  apt-get install -y xvfb && \
  apt-get install -y libxi6 && \
  apt-get install -y libgconf-2-4 && \
  apt-get install -y git && \
  apt-get install -y vim && \
  apt-get install -y jq && \
  apt-get install -y ruby-full && \
  apt-get install -y ca-certificates && \
  apt-get install -y apt-transport-https && \
  apt-get install -y build-essential && \
  chsh -s $(which zsh) 

RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y libgtk2.0-0:i386

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

# install Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable

# install ChromeDriver
RUN curl https://chromedriver.storage.googleapis.com/78.0.3904.105/chromedriver_linux64.zip --output chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  mv chromedriver /usr/bin/chromedriver && \
  chown root:root /usr/bin/chromedriver && \
  chmod +x /usr/bin/chromedriver

# Add SAP root CA to container
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAP%20Global%20Root%20CA.crt' -o '/usr/share/ca-certificates/SAP_Global_Root_CA.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAP_Global_Root_CA.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAPNetCA_G2.crt' -o '/usr/share/ca-certificates/SAPNetCA_G2.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAPNetCA_G2.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAP%20Global%20Sub%20CA%2002.crt' -o '/usr/share/ca-certificates/SAP_Global_Sub_CA_02.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAP_Global_Sub_CA_02.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAP%20Global%20Sub%20CA%2004.crt' -o '/usr/share/ca-certificates/SAP_Global_Sub_CA_04.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAP_Global_Sub_CA_04.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAP%20Global%20Sub%20CA%2005.crt' -o '/usr/share/ca-certificates/SAP_Global_Sub_CA_05.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAP_Global_Sub_CA_05.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAP%20Cloud%20Root%20CA.crt' -o '/usr/share/ca-certificates/SAP_Cloud_Root_CA.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAP_Cloud_Root_CA.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAPPassportG2.crt' -o '/usr/share/ca-certificates/SAPPassportG2.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAPPassportG2.crt | tee -a /etc/ssl/certs/ca-certificates.crt
RUN curl -ks 'http://aia.pki.co.sap.com/aia/SAP%20SSO%20CA%20G2.crt' -o '/usr/share/ca-certificates/SAP_SSO_CA_G2.crt' && /usr/sbin/update-ca-certificates
RUN cat /usr/share/ca-certificates/SAP_SSO_CA_G2.crt | tee -a /etc/ssl/certs/ca-certificates.crt

CMD ["zsh"]
