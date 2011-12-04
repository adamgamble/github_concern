module GithubConcern
  class Engine < Rails::Engine
    def self.config
      yield(self)
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
  end
end
