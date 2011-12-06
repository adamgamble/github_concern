require 'spec_helper'

describe GithubController do
  describe "GET index" do
    it "returns 200" do
      get :index
      response.should be_success
    end
  end
end
