class List < ActiveRecord::Base
  validates_presence_of :title, :user_id
  validates_uniqueness_of :title, scope: :user_id
end
