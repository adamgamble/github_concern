# Github Concern

Github Concern is a library to make integrating your application with github
braindead simple.  It has the following useful features:

* Provides a controller to respond to github post-push service hooks.
* Provides models to store the information github sends you.
* Provides a DSL for easily specifying which objects in your system should be
  associated with commits.
* Provides a DSL to specify actions in your system that should be taken as a
  result of specific commits being seen.  For instance, in a time tracking
  system you might add something that responded to commits that had "\[HOURS:
  3.5\]" in them by creating a WorkUnit in the system, associated with that
  commit, for 3.5 hours.

## Installation

First, add github\_concern to your Gemfile:

    gem 'github_concern', :git => 'http://github.com/adamgamble/github_concern.git'
    bundle install

Now github\_concern is available to your application.  Next, add a service hook
to your github repo that posts to http://your\_url/github\_integration

Add this to config/initializers/github\_concern.rb:

    GithubConcern::Engine.config do |gc|
      gc.user_lambda = lambda {|email| User.find_by_email email}
      gc.user_class  = User
    end

You can adjust the lambda to fit your needs for determining a user.

You need to create tables to store the commits and pushes that the github web
hook is going to be sending you.  Run this command to install the migrations:

    rake github_concern_engine:install:migrations

You can configure whatever models you want to be associated with the git pushes:

    class SomeModel < ActiveRecord::Base
      github_concern :repo => :github_repo, :branch => :github_branch

      def github_concern_callback git_push
      end
    end

:github\_repo, and :github\_branch represent attributes on the model

Now when someone pushes to a repo that has the service hook, information about
that will be stored in the database and associated to whatever models specified.
It will also call the github\_concern\_callback method on the object if it
exists.

## Contributing

Fork our repo, make a feature branch, push to it.  Send us a pull request.
We'll communicate back and forth via the github interface.  All contributions
are welcome.  Plase inform us of issues via the github issue tracker

## Authors

* Adam Gamble
* Josh Adams

## License

See the MIT-LICENSE file for details.
