FROM ruby:1.9.3

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

#COPY packages /usr/src/app/
#RUN /bin/bash -c "apt-get update && apt-get install -y \$(cat packages) --no-install-recommends && rm -rf /var/lib/apt/lists/*"

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

RUN gem install rack -v 1.4

EXPOSE 5000

ENV OFFLINE=offline
ENV PORT=5000
ENV PUBLIC_HOST=http://localhost:5000

CMD [ "rackup", "config.ru", "-p", "5000" ]