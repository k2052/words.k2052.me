---
title: "Building API's with Grape Part 1: Getting Started"
---

[Grape](https://github.com/intridea/grape) is a microy-RESTY-framework (why yes, that is a real term) built directly 
on top of Rack with a DSL focused on building APIs. Being built directly on Rack makes it compatible with pretty 
much every other framework. Grape apps can be mounted inside of existing Rails, Sinatra, Padrino apps etc. It is awesome. You'll love it, trust me.

To install Grape -- and I'm sure you saw this coming -- you have to journey to a far off land
and integrate into the local culture. Once integrated, you must meet a pretty local Italian girl, 
woo her and fall in love under an Italian sunset. Once in love, you must win the approval of her family in an
ancient long since past custom called "dinner". At dinner, you must regal the parents with tales of your achievements 
like that time you graduated from a prestigious university and when you learned how to pronounce some french words.

Once you have won the both her heart and the parents blessing, you marry her at a beautiful Greek wedding.
Attended by the local mayor, a number of relatives that seems suspiciously improbable, 
your hi-jinks prone friend Jerry (in a series of your wedding photos Jerry is seen falling in slow-motion into the fountain) and a chipmunk that just seems to show up everywhere.

You buy a five bedroom home on 2.5 acres. You settle into a routine of freelance programming,
local wine festivals and a monthly movie night. One day after reading of a Kickstarted local winery
you are inspired to acquire grapes. This had been building for many years, after all,
you had read Gary V and knew if he could do it then you could do it. You start growing grapes and crushing grapes and 
kickstarting. 

On the eve of your 35th birthday your restaurant _The Strange Chipmunk_ opens. The first bottle of wine for the season is served up to the local mayor. After a long but wonderful day you retire to your house. You sit down into your favorite chair, which looks out through the large windows into your yard where your wife and 2.5 kids 
(Timmy lost his lower half chasing a chipmunk into a wood chipper) play. You look at your beautiful wife and kids and reflect on your perfect life. You are finally ready. Ready to install Grape.

## Installation

You just have to add this to your Gemfile:

    gem "grape"
{: .language-ruby}

And then run:

    $ bundle install

A big selling point for Grape is that it is built on Rack. A class that inherits from `Grape::API` 
is a valid Rack app. This means that the simplest Grape app is just a class:
    
    # app.rb
    class Notes < Grape::API
      version 'v1'
      format :json

      resource :notes do
        desc "Return notes"
        get do
          Note.all()
        end
      end
    end
{: .language-ruby}

Because Grape classes are just Rack apps we can place this in a `config.ru` file and we get a bootable app for 
free:

    require File.expand_path('../app', __FILE__)

    run Notes
{: .language-ruby}

In practice, things aren't so simple. We quickly start to wonder how we would structure anything more complicated than
a one endpoint API. For example, where would we put multiple controllers, and how would they work together without
exploding the TARDIS and breaking the Moon? 

Since Grape controllers are Rack apps we can chain them together and mount them like Rack apps.
The simplest solution to our two controller problem would be to just mount them both:

    require File.expand_path('../app', __FILE__)
    
    use NotesAPI
    run TasksAPI
{: .language-ruby}

This would mount both Grape controllers to "/". The drawback of course is that we miss out on a lot of
Grape's routing features like nesting and scoping. In fact, if one of these was nested it would break every thing
including the kitchen sink and especially the shower. You'd be up a controller without a route.

Grape itself provides a way to mount other Grape controllers. To mount two or more controllers we can create a 
"container controller" and then mount our other controllers to it:

    # app.rb
    class App < Grape::API
      mount NotesAPI
      mount TasksAPI
    end
{: .language-ruby}

Then in our config.ru file we simply run the `App` class:

    require File.expand_path('../app', __FILE__)
    
    run App
{: .language-ruby}

## Testing 

At this point, I could just throw you out into the world and say "go forth and build APIs"; but right now you know just enough to be dangerous and you'd probably hurt yourself. Before you go forth we need to cover some safety 
procedures like testing and stuff. Grape apps are just Rack apps which means we test them like we do Rack apps. 

First, we add "rack-test" to our `Gemfile`:

    group :test do
      gem 'rspec'
      gem 'rack-test', require: 'rack/test'
      gem 'shoulda-matchers'
    end
{: .language-ruby}

Then a `Rakefile`:

    #!/usr/bin/env rake
    require File.expand_path('../app', __FILE__)

    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:spec)
    task :default => :spec
{: .language-ruby}

Then a `spec/spec_helper.rb` file:

    ENV['RACK_ENV'] = 'test'
    require File.expand_path("../../app", __FILE__)

    RSpec.configure do |conf|
      conf.include Rack::Test::Methods
    end

    def app
      App.new
    end
{: .language-ruby}

Then to test it we simply add a spec file with contents like:

    describe Notes::API
      it "should return notes" do
        get "/notes"
        last_response.status.should == 200
      end
    end
{: .language-ruby}

## Deploying

Since Grape apps are just Rack apps deploying is rather straightforward. You just need a config.ru file
and a Ruby server to run against it.

Add a server to your `Gemfile`:

    gem 'puma'
{: .language-ruby}

And a `Procfile` that calls it:

    web: bundle exec puma -p $PORT -e $RACK_ENV

Then you will be good to go. Don't blow anything up. Consult the [documentation](https://github.com/intridea/grape) 
and be sure to check out some example repos; 

- [https://github.com/k2052/notes-example-api.grape](https://github.com/k2052/notes-example-api.grape) 
- [https://github.com/k2052/afraidTODO.api](https://github.com/k2052/afraidTODO.api)
- [https://github.com/tribute/tribute-api](https://github.com/tribute/tribute-api)
- [https://github.com/intridea/grape/wiki#apps](https://github.com/intridea/grape/wiki#apps)

I'll see you in the next part. And seriously, don't blow anything up.


