class GithubController < ApplicationController
  def payload
    render :nothing => true, :status => 500 and return unless params["payload"]
    GitPush.create(:payload => JSON.parse(params["payload"]))
    render :nothing => true, :status => 200
  end
end
