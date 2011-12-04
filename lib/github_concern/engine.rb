module GithubConcern
  class Engine < Rails::Engine
    @@github_concerns = {}
    def self.config
      yield(self)
    end

    def self.add_class(class_constant, options)
      @@github_concerns[class_constant.to_s] = options
    end

    def self.github_concerns
      @@github_concerns
    end

    def self.user_lambda= find_user_lambda
      @@user_lambda = find_user_lambda
    end

    def self.user_lambda
      @@user_lambda
    end

    def self.user_class= user_class_constant
      @@user_class= user_class_constant
      @@user_class.class_eval { has_many :git_pushes }
      @@user_class
    end

    def self.user_class
      @@user_class
    end

    def self.user_class_symbol
      @@user_class.try(:to_s).try(:downcase).try(:to_sym)
    end

    def self.determine_user(email)
      @@user_lambda.call(email)
    end

    def self.add_github_concernable_relationship_to_class(class_constant)
      class_constant.class_eval {
        has_many :github_concernables, :class_name => "GithubConcernableGitPush", :as => :github_concernable
        has_many :git_pushes, :through => :github_concernables
      }
    end
  end
end
