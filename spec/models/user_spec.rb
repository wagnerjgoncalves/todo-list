require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }

    describe 'uniqueness' do
      let!(:user) { create(:user, email: 'sample@example.com') }

      subject do
        build(:user, email: user.email)
      end

      it { should validate_uniqueness_of(:email).case_insensitive }
    end
  end
end
