# frozen_string_literal: true

require_relative '../../spec_helper'

describe CgtraderLevels::User do
  subject(:user_level_down) { user.update! reputation: 1 }

  let(:user_level_up) { user.update! reputation: 10 }
  let!(:level1) { create(:level) }
  let!(:level2) { create(:level, number: 1, experience: 10, title: 'Second level', privileges: [privilege]) }
  let!(:level3) { create(:level, number: 2, experience: 25, title: 'Third level', privileges: [privilege2]) }
  let(:user) { create(:user) }
  let(:privilege) { create(:privilege, privilege_type: :tax_reduction, amount: 5) }
  let(:privilege2) { create(:privilege, privilege_type: :tax_reduction, amount: 7) }

  let(:user_multilevel_up) { user.update! reputation: 25 }

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
      expect { user_level_up }.to change { user.reload.level }.from(level1).to(level2)
    end

    it "from 'First level' to 'Second level' with more reputation than necessary" do
      expect { user.update!(reputation: 11) }.to change { user.reload.level }.from(level1).to(level2)
    end
  end

  describe 'when level up bonuses & privileges' do
    it 'gives 5 coins to user when level 2' do
      expect { user_level_up }.to change { user.reload.coins }.by(5)
    end

    it 'reduces tax rate by 1 when level 2' do
      expect { user_level_up }.to change(user, :tax_with_level_bonuses).by(-4)
    end
  end

  describe 'when multi-level up' do
    context 'when level up from level 1 to level 3' do
      it 'levels up the user' do
        expect { user_multilevel_up }.to change(user, :level).from(level1).to(level3)
      end

      it 'gives 15 coins to user when level 3' do
        expect { user_multilevel_up }.to change { user.reload.coins }.by(15)
      end

      it 'reduces tax rate by 1 when level 2' do
        expect { user_multilevel_up }.to change(user, :tax_with_level_bonuses).by(-6)
      end
    end
  end

  describe 'when level down' do
    context 'when level down from level 3 to level 1' do
      before { user_multilevel_up }

      it 'levels up the user' do
        expect { user_level_down }.to change(user, :level).from(level3).to(level1)
      end

      it 'does not gain any coins' do
        expect { user_level_down }.not_to change(user, :coins)
      end

      it 'regain the basic level 1 tax reduction' do
        expect { user_level_down }.to change(user, :tax_with_level_bonuses).to(user.tax - level1.privileges.tax_reduction.pluck(:amount).first)
      end
    end
  end
end
