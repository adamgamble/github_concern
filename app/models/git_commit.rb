class GitCommit < ActiveRecord::Base
  belongs_to :git_push
  serialize :payload
end
