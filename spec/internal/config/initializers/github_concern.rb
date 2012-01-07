GithubConcern::Engine.config do |gc|
  gc.user_lambda = lambda {|email| User.find_by_email email}
  gc.user_class  = User
  gc.token       = "my_github_token"
end

Module.constants.select do |constant_name|
  constant = constant_name.to_s.constantize
  if not constant.nil? and constant.is_a? Class and constant.superclass == ActiveRecord::Base
    constant.inspect
  end
end
