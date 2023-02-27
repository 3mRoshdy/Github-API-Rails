#!/bin/bash
set -e

bundle install

./bin/rails tailwindcss:install

# Remove a potentially pre-existing server.pid for Rails.

echo "Deleting server.pid file..."

rm -f /tmp/pids/server.pid


# Start the server.

echo "Starting rails server..."

bundle exec rails server