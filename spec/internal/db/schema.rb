ActiveRecord::Schema.define do
  create_table(:users, :force => true) do |t|
    t.string :email
    t.timestamps
  end

  create_table(:projects, :force => true) do |t|
    t.string :github_repo
    t.timestamps
  end

  create_table(:tickets, :force => true) do |t|
    t.string :github_repo
    t.string :github_branch
    t.timestamps
  end

  create_table(:git_pushes, :force => true) do |t|
    t.text :payload
    t.timestamps
  end
end
