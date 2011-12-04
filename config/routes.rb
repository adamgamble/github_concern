Rails.application.routes.draw do
  post "/github_integration", :to => "github#payload"
end
