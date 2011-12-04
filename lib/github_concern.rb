require "github_concern/engine"

module GithubConcern
  extend ActiveSupport::Concern
  included do
  end

  module ClassMethods
    def github_concern(options = {})
    end
  end
end
ActiveRecord::Base.send :include, GithubConcern
