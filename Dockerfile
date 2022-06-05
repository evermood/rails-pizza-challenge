FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y postgresql-client nodejs
RUN mkdir /myapp
WORKDIR /myapp
# COPY . /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
