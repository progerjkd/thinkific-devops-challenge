FROM ruby:2.6.3

RUN apt update
RUN apt install -y libpq-dev

WORKDIR /app

COPY . /app
RUN bundle install 
RUN rm -f /app/tmp/pids/server.pid

EXPOSE 3000

CMD rails db:setup && rails server -b 0.0.0.0