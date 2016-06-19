require 'rails_helper'

describe SubTask do
  describe 'associations' do
    it { should belong_to :task }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
  end
end
