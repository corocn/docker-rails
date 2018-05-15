FROM ruby:2.5.1

ENV DEBIAN_FRONTEND noninteractive

RUN bash -c "curl -sL https://deb.nodesource.com/setup_8.x | bash -" && \
      apt-get update && \
      apt-get install -y --no-install-recommends nodejs libssl1.0-dev unzip && \
      apt-get clean && \
      rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN npm install -g yarn && npm install -g n && n lts

RUN gem i bundler --no-document

USER root

WORKDIR /app

ADD Gemfile /app/Gemfile

ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app

EXPOSE 3000

CMD bash -l -c 'bundle exec rails server -p 3000 -b 0.0.0.0'