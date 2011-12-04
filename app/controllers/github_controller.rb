class GithubController < ApplicationController
  def payload
    GitPush.create(:payload => JSON.parse(params["payload"]))
    render :nothing => true, :status => 200
  end
end
