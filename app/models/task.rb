class Task < ActiveRecord::Base
  validates :title, presence: true
  scope :active, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }

  def complete!
    update_attribute(:completed, true)
  end

  def restore!
    update_attribute(:completed, false)
  end
end
