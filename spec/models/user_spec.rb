require_relative '../spec_helper'

describe 'CgtraderLevels::User' do

  let(:user) { CgtraderLevels::User.create! }
  let!(:level1) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
  let!(:level2) { CgtraderLevels::Level.create!(experience: 10, title: 'First level') }
  let!(:level3) { CgtraderLevels::Level.create!(experience: 13, title: 'First level') }

  describe 'new user' do
    it 'has 0 reputation points' do
      expect(user.reputation).to eq(0)
    end

    it "has assigned 'First level'" do
      expect(user.level).to eq(level1)
    end
  end

  describe 'level up' do
    it "level ups from 'First level' to 'Second level'" do
      expect { user.update_attribute(:reputation, 10) }.to change { user.reload.level }.from(level1).to(level2)
    end

    it "level ups from 'First level' to 'Second level'" do
      expect { user.update_attribute(:reputation, 11) }.to change { user.reload.level }.from(level1).to(level2)
    end
  end

  describe 'level up bonuses & privileges' do
    it 'gives 7 coins to user' do
      pending

      user = CgtraderLevels::User.create!(coins: 1)

      expect { user.update_attribute(reputation: 10) }.to change { user.reload.coins }.from(1).to(8)
    end

    it 'reduces tax rate by 1'
  end
end
