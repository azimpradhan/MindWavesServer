class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :lat, :float

    add_column :users, :long, :float

    add_column :users, :udid, :string

  end
end
