class SubTaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :completed
end
