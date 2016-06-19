require 'rails_helper'

describe Task do
  describe 'associations' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :kind }

    it { should allow_value('particular').for(:kind) }
    it { should allow_value('common').for(:kind) }
  end
end
