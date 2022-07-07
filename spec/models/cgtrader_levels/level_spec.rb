# frozen_string_literal: true

require_relative '../../spec_helper'

describe CgtraderLevels::Level do
  subject(:level_up_privileges) { level.privileges.select(&:level_up_coins?) }

  let!(:level) { create(:level) }

  describe 'Level-privileges' do
    context 'when Level Up' do
      it 'have level-up coins privilages' do
        expect(level_up_privileges.empty?).to be(false)
      end

      it 'have level-up coins privilages in the correct ammount' do
        expect(level_up_privileges.first.amount).to eq(level.send(:coins_bonuses, level.number))
      end
    end
  end
end
