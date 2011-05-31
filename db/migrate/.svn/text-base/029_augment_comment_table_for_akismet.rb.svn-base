class AugmentCommentTableForAkismet < ActiveRecord::Migration
  def self.up
    rename_column :comments, :ip, :user_ip
    add_column :comments, :user_agent, :string
    add_column :comments, :referrer, :string
    remove_column :comments, :is_approved
    add_column :comments, :approved, :boolean, :default => false, :null => false
    Comment.update_all("approved=1")
    nn7 = 'Use Akismet spam filtering?'
    ds7 = 'Use Akismet to filter spam?'
    execute "INSERT INTO preferences (nice_name, description, name, value) VALUES ('#{nn7}', '#{ds7}', 'akismet_filter', 'yes')"
    
  end

  def self.down
    remove_column :comments, :user_ip
    remove_column :comments, :user_agent
    remove_column :comments, :referrer
    remove_column :comments, :approved
    rename_column :ip, :new_column_name, :column_name
    rename_column :comments, :user_ip, :ip
    add_column :comments, :is_approved, :boolean, :default => false
    execute "DELETE FROM preferences WHERE name = 'akismet_filter'"
  end
end
