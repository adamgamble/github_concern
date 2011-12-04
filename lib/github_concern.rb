require "github_concern/engine"

module GithubConcern
  extend ActiveSupport::Concern
  included do
  end

  module ClassMethods
    def github_concern(options = {})
      GithubConcern::Engine.add_class(self, options)
      GithubConcern::Engine.add_github_concernable_relationship_to_class(self)
    end
  end
end
ActiveRecord::Base.send :include, GithubConcern
