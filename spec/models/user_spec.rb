require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many :restaurants }
  let!(:user) do
    User.create(email: 'test2test.com',
                password: 'test2test',
                password_confirmation: 'test2test')
  end

  let(:restaurant) {double :restaurant, user_id: 1}

  describe "#created_restaurant?" do
    it "should return true when restaurant passed in belongs to user" do
      # allow(restaurant).to receive(user)
      expect(user.created_restaurant?(restaurant)).to eq(true)
    end
  end
end
