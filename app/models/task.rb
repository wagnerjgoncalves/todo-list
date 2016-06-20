class Task < ActiveRecord::Base
  enum kind: { particular: 0, common: 1 }

  belongs_to :user
  has_many :sub_tasks

  validates :description, :kind, presence: true
  validates :kind, inclusion: { in: Task.kinds.keys }

  scope :by_user, ->(value) { where(user_id: value) }
  scope :not_user, ->(value) { where.not(user_id: value) }
end
