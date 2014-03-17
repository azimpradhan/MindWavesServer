class UserView < ActiveRecord::Base
  belongs_to :source_user, :class_name => 'User', :foreign_key => :source_user_id
  belongs_to :dest_user, :class_name => 'User', :foreign_key => :dest_user_id
end
