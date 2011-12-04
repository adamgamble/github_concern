class GitPush < ActiveRecord::Base
  before_create :associate_user
  after_create :associate_git_concernables

  serialize :payload
  belongs_to GithubConcern::Engine.user_class_symbol, :foreign_key => :user_id
  has_many :github_concernable_git_pushes
  has_many :github_concernables, :through => :github_concernable_git_pushes

  private
  def associate_user
    email = payload["pusher"]["email"]
    user = GithubConcern::Engine.determine_user(email)
    self.user_id = user.id if user
  end

  def associate_git_concernables
    GithubConcern::Engine.github_concerns.each_pair do |class_name, github_concern_hash|
      github_concern_hash.each_pair do |github_concern_key, github_concern_method|
        case github_concern_key
        when :repo
          Rails.logger.warn "Looking for repos on #{class_name}"
          repo_name = payload["repository"]["name"]
          Rails.logger.warn "Running method find_all_by_#{github_concern_method} on #{class_name} with argument #{repo_name}"
          objects = class_name.constantize.send("find_all_by_#{github_concern_method}".to_sym,repo_name)
          Rails.logger.warn "Found #{objects.count}"
          objects.each do |object|
            github_concernable_git_push = self.github_concernable_git_pushes.new
            github_concernable_git_push.github_concernable = object
            github_concernable_git_push.save
          end
        end
      end
    end
  end
end
