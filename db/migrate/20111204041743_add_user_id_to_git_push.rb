class AddUserIdToGitPush < ActiveRecord::Migration
  def change
    add_column :git_push, :user_id, :integer
  end
end
