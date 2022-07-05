# frozen_string_literal: true

require_relative '../../spec_helper'

describe CgtraderLevels::User do
  let(:user) { described_class.create! }
  let!(:level1) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
  let!(:level2) { CgtraderLevels::Level.create!(experience: 10, title: 'Second level') }

  let(:privilege) { CgtraderLevels::Privilege.create! privilege_type: :tax_reduction, amount: 1 }
  let(:privilege2) { CgtraderLevels::Privilege.create! privilege_type: :tax_reduction, amount: 5 }

  describe 'when new user' do
    it 'has 0 reputation points' do
      expect(user.reputation).to eq(0)
    end

    it "has assigned 'First level'" do
      expect(user.level).to eq(level1)
    end
  end

  describe 'when level up' do
    it "from 'First level' to 'Second level'" do
      expect { user.update_attribute(:reputation, 10) }.to change { user.reload.level }.from(level1).to(level2)
    end

    it "from 'First level' to 'Second level' with more reputation than necessary" do
      expect { user.update_attribute(:reputation, 11) }.to change { user.reload.level }.from(level1).to(level2)
    end
  end

  describe 'when level up bonuses & privileges' do
    it 'gives 7 coins to user when level 2' do
      expect { user.update_attribute(:reputation, 10) }.to change { user.reload.coins }.from(0).to(7)
    end

    it 'reduces tax rate by 1 when level 2' do
      expect { user.update_attribute(:reputation, 10) }.to change(user, :tax_with_level_bonuses).by(-1)
    end
  end
end
