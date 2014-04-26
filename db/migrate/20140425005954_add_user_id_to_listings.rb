class AddUserIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :user_id, :integar
  end
end
