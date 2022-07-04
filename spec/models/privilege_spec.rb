require_relative '../spec_helper'

describe CgtraderLevels::Privilege do

  let(:privilege) { described_class.create! privilege_type: :tax_reduction, amount: 1 }
  let(:privilege2) { described_class.create! privilege_type: :tax_reduction, amount: 5 }
  let!(:level1) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
  let!(:level2) { CgtraderLevels::Level.create!(experience: 10, title: 'Second level') }
  let!(:level_privilege) { level1.privileges << privilege }
  let!(:level_privilege2) { level2.privileges << privilege2 }

  describe 'Level-privileges' do
    context 'Level 1 should have 1 tax reduction' do
      it { expect(level1.privileges).to include(privilege) }
    end
    context 'Level 2 should have 5 tax reduction' do
      it { expect(level2.privileges).to include(privilege2) }
    end
    context 'Level 2 should not have 1 AND 5 tax reduction' do
      it { expect(level2.privileges).not_to include(privilege) }
    end
  end
end
