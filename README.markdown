# Github Concern
***
Add a service hook to your github repo that posts to http://your\_url/github\_integration

Add this to config/initializers/github\_concern.rb:

    GithubConcern::Engine.config do |gc|
      gc.user_lambda = lambda {|email| User.find_by_email email}
      gc.user_class  = User
    end

You can adjust the lambda to fit your needs for determining a user.

Run this command to install the migrations:

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
