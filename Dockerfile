FROM ruby:3.2.2-slim

RUN apt-get update -y && apt-get install build-essential -yqq \
    postgresql-client \
    libpq-dev \
    libvips \
    curl

# Install nodejs 18
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends yarn

RUN gem install bundler -v 2.4

WORKDIR /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY package.json yarn.lock ./

RUN yarn install

COPY . ./

ENTRYPOINT ["bin/sidekiq"]
