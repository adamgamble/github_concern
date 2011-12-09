require 'spec_helper'

describe GithubController do
  describe "POST payload" do
    it "returns 500 when not sending a payload" do
      post :payload
      response.code.should == "500"
    end
    it "returns 200 when sending a valid payload" do
      payload = {"pusher"=>{"name"=>"test_user", "email"=>"test@test.com"}, "repository"=>{"name"=>"some_repo", "size"=>15488, "has_wiki"=>true, "created_at"=>"2011/11/24 21:24:54 -0800", "private"=>false, "watchers"=>1, "fork"=>false, "url"=>"https://github.com/test_user/some_repo", "language"=>"Ruby", "pushed_at"=>"2011/12/05 20:17:17 -0800", "has_downloads"=>true, "open_issues"=>0, "has_issues"=>true, "homepage"=>"", "description"=>"", "forks"=>1, "owner"=>{"name"=>"test_user", "email"=>"test@test.com"}}, "forced"=>false, "after"=>"06e8f192e2e2c4c36f0759520e37cbcaea0cfb05", "deleted"=>false, "ref"=>"refs/heads/testing", "commits"=>[{"modified"=>["README"], "added"=>[], "timestamp"=>"2011-12-05T20:17:13-08:00", "removed"=>[], "author"=>{"name"=>"test_user", "username"=>"test_user", "email"=>"test@test.com"}, "url"=>"https://github.com/test_user/some_repo/commit/06e8f192e2e2c4c36f0759520e37cbcaea0cfb05", "id"=>"06e8f192e2e2c4c36f0759520e37cbcaea0cfb05", "distinct"=>true, "message"=>"readme"}], "compare"=>"https://github.com/test_user/some_repo/compare/bcd84c3...06e8f19", "before"=>"bcd84c38982232c0242539e41799a7826bd162ae", "created"=>false}
      post :payload, :payload => payload.to_json
      response.should be_success
      GitPush.count.should == 1
    end
  end
end
