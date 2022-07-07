# frozen_string_literal: true

require_relative '../../spec_helper'

describe CgtraderLevels::Privilege do
  let!(:level1) { create(:level) }
  let!(:level2) { create(:level, experience: 10, title: 'Second level') }
  let(:privilege) { level1.privileges.create! privilege_type: :tax_reduction, amount: 1 }
  let(:privilege2) { level2.privileges.create! privilege_type: :tax_reduction, amount: 5 }

  describe 'Level-privileges' do
    context 'when Level 1 should have 1 tax reduction' do
      it { expect(level1.privileges).to include(privilege) }
    end

    context 'when Level 2 should have 5 tax reduction' do
      it { expect(level2.privileges).to include(privilege2) }
    end

    context 'when Level 2 should not have 1 AND 5 tax reduction' do
      it { expect(level2.privileges).not_to include(privilege) }
    end
  end
end
