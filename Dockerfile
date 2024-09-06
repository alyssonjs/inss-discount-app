# syntax=docker/dockerfile:1
FROM ruby:2.7.2

# Install dependencies and tools
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  curl

# Create the application directory
RUN mkdir /inss-discount-app
WORKDIR /inss-discount-app

# Copy necessary files
COPY Gemfile /inss-discount-app/Gemfile
COPY Gemfile.lock /inss-discount-app/Gemfile.lock
COPY yarn.lock /inss-discount-app/yarn.lock
COPY package.json /inss-discount-app/package.json
COPY babel.config.js /inss-discount-app/babel.config.js
COPY postcss.config.js /inss-discount-app/postcss.config.js

# Install Yarn via npm
RUN apt-get install -y npm && npm install -g yarn

# Install Bundler (compatible version) and project dependencies
RUN gem install bundler -v 2.4.22
RUN bundle install
RUN yarn install

# Copy the rest of the application code
COPY . /inss-discount-app

# Add the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000
EXPOSE 3000

# Set the default command
CMD ["rails", "server", "-b", "0.0.0.0"]
