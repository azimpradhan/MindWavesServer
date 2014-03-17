class CreateUserViews < ActiveRecord::Migration
  def change
    create_table :user_views do |t|
      t.integer :source_user_id
      t.integer :dest_user_id

      t.timestamps
    end
  end
end
