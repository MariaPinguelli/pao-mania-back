# Dockerfile
FROM ruby:3.3.4

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock /app/

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . /app

# Expose port for Puma
EXPOSE 3000

# Command to start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
