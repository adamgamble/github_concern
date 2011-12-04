class GithubConcernableGitPush < ActiveRecord::Base
  belongs_to :github_concernable, :polymorphic => true
  belongs_to :git_push
end
