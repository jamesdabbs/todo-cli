class Item < ActiveRecord::Base
  validates_presence_of :list_id, :name
  validates_uniqueness_of :name, scope: :list_id
  validate :due_date_is_in_the_future

  def due_date_is_in_the_future
    if due_date.present? && due_date < Date.today
      errors.add :due_date, "can't be in the past"
    end
  end
end
