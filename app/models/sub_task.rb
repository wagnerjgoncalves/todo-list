class SubTask < ActiveRecord::Base
  belongs_to :task

  validates :description, presence: true
end
