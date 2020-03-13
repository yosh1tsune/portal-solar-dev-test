FROM ruby:2.6.3

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get update && \
      apt-get install -y vim nodejs
RUN npm install -g yarn

RUN apt-get update && \
    apt-get install -y wget firefox-esr && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.17.0/geckodriver-v0.17.0-linux64.tar.gz && \
    tar -zxvf geckodriver-v0.17.0-linux64.tar.gz && \
    chmod +x geckodriver && \
    mv geckodriver /usr/local/bin && \
    rm geckodriver-v0.17.0-linux64.tar.gz

WORKDIR /portal-solar-dev-test

ADD . /portal-solar-dev-test

RUN bundle install
