require 'spec_helper'

describe GithubController do
  describe "POST payload" do
    it "returns 500 when not sending a payload" do
      post :payload
      response.code.should == "500"
    end

    describe "when sending a valid payload" do
      before(:each) do
        payload = valid_payload_hash.to_json
        post :payload, :payload => payload
      end

      it "returns 200 when sending a valid payload" do
        response.should be_success
      end

      it "should create a git push" do
        GitPush.count.should == 1
      end

      it "should set the payload of that git push to payload" do
        GitPush.last.payload.should == valid_payload_hash
      end
    end
  end
end
