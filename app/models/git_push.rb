class GitPush < ActiveRecord::Base
  before_create :associate_user
  after_create :associate_git_concernables, :build_commits

  serialize :payload
  belongs_to GithubConcern::Engine.user_class_symbol, :foreign_key => :user_id
  has_many :github_concernable_git_pushes
  has_many :github_concernables, :through => :github_concernable_git_pushes
  has_many :git_commits

  private
  def associate_user
    email = payload["pusher"]["email"]
    user = GithubConcern::Engine.determine_user(email)
    self.user_id = user.id if user
  end

  def build_commits
    payload["commits"].each do |commit|
      git_commits.create(:payload => commit)
    end
  end

  def associate_git_concernables
    GithubConcern::Engine.github_concerns.each_pair do |class_name, github_concern_hash|
      bucket = class_name.constantize
      github_concern_hash.each_pair do |github_concern_key, github_concern_method|
        case github_concern_key
        when :repo
          git_variable = payload["repository"]["name"]
        when :branch
          git_variable = payload["ref"].gsub("refs/heads/","")
        when :class_method
          objects = bucket.send(github_concern_method,payload["repository"]["name"],payload["ref"].gsub("refs/heads/",""))
          if objects.respond_to?(:each)
            objects.each {|object| associate_to_object object }
          else
            associate_to_object objects
          end
          next
        end
        bucket = bucket.where(github_concern_method => git_variable)
      end
      bucket.all.each do |object|
        associate_to_object object
      end
    end
  end

  def associate_to_object object
    github_concernable_git_push = self.github_concernable_git_pushes.new
    github_concernable_git_push.github_concernable = object
    github_concernable_git_push.save
    object.github_concern_callback(self) if object.respond_to?(:github_concern_callback)
  end
end
