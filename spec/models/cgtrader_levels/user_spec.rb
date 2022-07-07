# frozen_string_literal: true

require_relative '../../spec_helper'

describe CgtraderLevels::User do
  let!(:level1) { create(:level) }
  let!(:level2) { create(:level, number: 1, experience: 10, title: 'Second level', privileges: [privilege]) }

  let(:user) { create(:user) }
  let(:privilege) { create(:privilege, privilege_type: :tax_reduction, amount: 5) }

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
      expect { user.update!(reputation: 10) }.to change { user.reload.level }.from(level1).to(level2)
    end

    it "from 'First level' to 'Second level' with more reputation than necessary" do
      expect { user.update!(reputation: 11) }.to change { user.reload.level }.from(level1).to(level2)
    end
  end

  describe 'when level up bonuses & privileges' do
    it 'gives 5 coins to user when level 2' do
      expect { user.update!(reputation: 10) }.to change { user.reload.coins }.by(5)
    end

    it 'reduces tax rate by 1 when level 2' do
      expect { user.update!(reputation: 10) }.to change(user, :tax_with_level_bonuses).by(-4)
    end
  end

  describe 'when multi-level up' do
    # WIP
  end

  describe 'when level down' do
    # WIP
  end
end
