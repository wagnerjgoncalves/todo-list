class Task < ActiveRecord::Base
  enum kind: { particular: 0, common: 1 }

  belongs_to :user
  has_many :sub_tasks

  validates :description, :kind, presence: true
  validates :kind, inclusion: { in: Task.kinds.keys }
end
