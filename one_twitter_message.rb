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

# Number of tweets
number = begin
  Integer(ARGV[0])
rescue ArgumentError, TypeError
  1
end

number = [1, number].max

# An infinite loop that triggers everytime a tweet is posted that matches
# the topics.
client.sample() do |object|
  if object.is_a?(Twitter::Tweet)
    # It's a tweet! Do anything you want!

    clean_tweet = object.text.gsub(/\s+/, ' ').strip
    
    # e.g. print the Tweet content
    puts "#{clean_tweet}"

    # Leave if number has been reached
    number -= 1
    break if number == 0
  end
end
