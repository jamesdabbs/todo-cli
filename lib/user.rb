class User < ActiveRecord::Base
  validates_presence_of :username, :password
  validates_length_of :password, minimum: 4
  validates_uniqueness_of :username

  # def lists
  #   List.where(user_id: id)
  # end
  has_many :lists

  # Bad: n+1 query
  # def items
  #   all_items = []
  #   lists.each do |l|
  #     all_items.push l.items
  #   end
  #   all_items.flatten
  # end

  # Better: 2 queries
  # def items
  #   list_ids = lists.pluck(:id)
  #   Item.where(list_id: list_ids)
  # end
  has_many :items, through: :lists
end
