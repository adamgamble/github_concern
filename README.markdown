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
