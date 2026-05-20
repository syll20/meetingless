FROM ruby:3.2-slim

# Install minimal build deps and node (some plugins expect node)
RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git libffi-dev nodejs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Ensure bundler installs gems into /usr/local/bundle (shared volume)
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Install gems (copy Gemfile first to leverage Docker layer cache)
COPY Gemfile Gemfile.lock* ./
RUN gem install bundler && bundle config set --local path "$BUNDLE_PATH" && bundle install --jobs "$BUNDLE_JOBS" --retry "$BUNDLE_RETRY"

# Copy site
COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--watch"]
