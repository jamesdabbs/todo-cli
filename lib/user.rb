class User < ActiveRecord::Base
  validates_presence_of :username, :password
  validates_length_of :password, minimum: 4
  validates_uniqueness_of :username
end
