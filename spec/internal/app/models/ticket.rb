class Ticket < ActiveRecord::Base
  github_concern :repo => :github_repo, :branch => :github_branch
end
