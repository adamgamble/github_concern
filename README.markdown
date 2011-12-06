# Github Concern
***
Add a service hook to your github repo that posts to http://your_url/github_integration

Add this to config/initializers/github_concern.rb

```Ruby
GithubConcern::Engine.config do |gc|
  gc.user_lambda = lambda {|email| User.find_by_email email}
  gc.user_class  = User
end
```

You can adjust the lambda to fit your needs for determining a user

run this command to install the migrations

```
rake github_concern_engine:install:migrations
```

You can configure whatever models you want to be associated with the git pushes

```Ruby
class SomeModel < ActiveRecord::Base
  github_concern :repo => :github_repo, :branch => :github_branch

  def github_concern_callback git_push
  end
end
```

:github_repo, and :github_branch represent attributes on the model

Now when someone pushes to a repo that has the service hook, information about that will be stored in the database and associated to whatever models specified. It will also call the github_concern_callback method on the object if it exists.
