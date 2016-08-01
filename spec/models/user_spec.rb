require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }

    it { is_expected.to have_many(:search_results) }
  end

  describe '.from_omniauth' do
    context 'when there is no user' do
      it 'should create a new user' do
        auth_hash = (FactoryGirl.build :auth_param).stringify_keys
        expect{
          User.from_omniauth(auth_hash)
        }.to change(User, :count).by(1)
      end
    end

    context 'when the params belongs to a user' do
      it 'should not create a new user' do
        user = create :user
        auth_hash = (FactoryGirl.build :auth_param, uid: user.uid, provider: user.provider).stringify_keys
        expect{
          User.from_omniauth(auth_hash)
        }.to change(User, :count).by(0)
      end
    end
  end
end
