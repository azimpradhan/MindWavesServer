class User < ActiveRecord::Base
has_many :user_views, :class_name => 'UserView', :foreign_key => :source_user_id, :order => ["updated_at ASC"], :dependent => :destroy
has_many :inverse_user_views, :class_name => 'UserView', :foreign_key => :dest_user_id, :order => ["updated_at ASC"], :dependent => :destroy

has_many :users_viewed, :through => :user_views,:order => ["user_views.updated_at ASC"], :source => :dest_user, :class_name => 'User'
has_many :viewers, :through => :inverse_user_views, :order => ["user_views.updated_at ASC"], :source => :source_user, :class_name => 'User'
end
