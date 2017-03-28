# Simple Twitter Hashtag Monitor

For the [Creative Coding Maastricht Meetup](https://www.meetup.com/Creative-Coding-Maastricht/). We'll use it in a project that fires up an Arduino connected light installation everytime someone tweets something that matches [#caracola](https://twitter.com/search?q=%23caracola). For great profit of course!

## Installation

Assuming you have a *nix system, and you have `ruby`, `rubygems`, `bundler` and `rbenv` installed. Then, clone this repository and run `bundle install`. Now that the dependencies are taken care of, you can start the script by running `bundle exec ruby twitter_hashtag_monitor.rb`. Enjoy the stream! YMMV.

## Twitter API keys

Go to [https://apps.twitter.com/](https://apps.twitter.com/) to get yer API keys.
Place them in a file called `.env` which you will copy from `env.example` by using the following command:

```sh
cp example.env .env
```

## Customization

In the file `twitter_hashtag_monitor.rb` you can set the filters you'd like in the `topics` variable, like so:

```ruby
topics = ['#coffee', '#caracola']
```

In the infinite loop you can plug any arbitrary code you want, e.g. to fire the Arduino.

```ruby
# Infinite loop
client.filter(track: topics.join(',')) do |object|
  if object.is_a?(Twitter::Tweet)
    # It's a matching tweet! Do anything you want!

    # e.g. print the Tweet content
    puts "[#{Time.now.strftime("%F %T")}] #{object.user.name}: #{object.text}"
  end
end
```

More documentation available in the [twitter gem](https://github.com/sferik/twitter) that powers the script.

## Thanks

Thank you [Caracola](https://caracolaspace.org/) for generously providing us with a place to host our meetups! We recommend anyone in the Maastricht NL area to keep a close eye on this space, because there's a ton of exciting stuff happening.
