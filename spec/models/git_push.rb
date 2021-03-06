require 'spec_helper'

describe GitPush do
  describe "when I create a new git push" do
    before(:all) do
      Project.class_eval {github_concern :repo => :github_repo }
      Ticket.class_eval {github_concern :repo => :github_repo, :branch => :github_branch }

      @project                = Project.create(:github_repo => "some_repo")
      @non_concerned_project  = Project.create()

      @ticket                 = Ticket.create(:github_repo => "some_repo", :github_branch => "testing")
      @unconcerned_ticket     = Ticket.create(:github_repo => "some_other_repo", :github_branch => "testing")
      @unconcerned_ticket_2   = Ticket.create(:github_repo => "some_repo", :github_branch => "testing_2")

      @user                   = User.create(:email => "test@test.com")
      @non_concerned_user     = User.create
      @git_push               = GitPush.create(:payload => valid_payload_hash)
    end

    it "should serialize the payload" do
      @git_push.reload
      @git_push.payload.should == valid_payload_hash
    end

    it "should automatically concern the user who pushed" do
      @user.git_pushes.include?(@git_push).should == true
    end

    it "should not concern the users who dont care" do
      @non_concerned_user.git_pushes.should == []
    end

    it "should automatically build commits" do
      GitCommit.count.should == 1
      @git_push.git_commits.should == [GitCommit.last]
      @git_push.git_commits.last.payload.should == {"modified"=>["README"], "added"=>[], "timestamp"=>"2011-12-05T20:17:13-08:00", "removed"=>[], "author"=>{"name"=>"test_user", "username"=>"test_user", "email"=>"test@test.com"}, "url"=>"https://github.com/test_user/some_repo/commit/06e8f192e2e2c4c36f0759520e37cbcaea0cfb05", "id"=>"06e8f192e2e2c4c36f0759520e37cbcaea0cfb05", "distinct"=>true, "message"=>"readme"}
    end

    it "should automatically concern the project" do
      @project.git_pushes.include?(@git_push).should == true
    end

    it "should not concern projects that dont care" do
      @non_concerned_project.git_pushes.should == []
    end

    it "should concern tickets that care" do
      @ticket.git_pushes.include?(@git_push).should == true
    end

    it "should not concern tickets that don't care" do
      @unconcerned_ticket.git_pushes.should == []
      @unconcerned_ticket_2.git_pushes.should == []
    end
  end
end
