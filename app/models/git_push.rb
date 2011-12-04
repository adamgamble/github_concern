class GitPush < ActiveRecord::Base
  before_create :associate_user

  serialize :payload
  belongs_to GithubConcern::Engine.user_class_symbol, :foreign_key => :user_id

  private
  def associate_user
    email = payload["pusher"]["email"]
    user = GithubConcern::Engine.determine_user(email)
    self.user_id = user.id if user
  end
end
