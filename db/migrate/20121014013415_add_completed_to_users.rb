class AddCompletedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :completed, :boolean, :null => false, :default => false
  end
end
