class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contest_creator, :boolean
  end
end
