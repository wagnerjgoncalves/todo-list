class SubTask < ActiveRecord::Base
  belongs_to :task

  validates :description, presence: true

  def completed!(value)
    update_attribute(:completed, value)
  end
end
