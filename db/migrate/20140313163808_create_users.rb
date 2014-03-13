class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :avatar_id
      t.string :username
      t.string :sound_filename

      t.timestamps
    end
  end
end
