class Project < ActiveRecord::Base
  github_concern :repo => :github_repo
end
