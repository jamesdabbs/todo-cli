class List < ActiveRecord::Base
  validates_presence_of :title, :user_id
  validates_uniqueness_of :title, scope: :user_id

  def user
    # if @user
    #   @user
    # else
    #   @user = User.find(user_id)
    # end
    @user ||= User.find(user_id)
  end
end
