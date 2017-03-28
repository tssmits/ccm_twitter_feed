require 'rubygems'
require 'bundler/setup'
require 'dotenv/load'
require 'twitter'

# Make sure you do `cp example.env .env` and create a Twitter API account
# and add the appropriate keys to the file `.env`.
client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

# Customize this to match your desires. Concatenated with OR.
topics = ['#coffee', '#caracola']

# An infinite loop that triggers everytime a tweet is posted that matches
# the topics.
client.filter(track: topics.join(',')) do |object|
  if object.is_a?(Twitter::Tweet)
    # It's a tweet! Do anything you want!

    # e.g. print the Tweet content
    puts "[#{Time.now.strftime("%F %T")}] #{object.user.name}: #{object.text}"
  end
end
