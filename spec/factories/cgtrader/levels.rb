# frozen_string_literal: true

FactoryBot.define do
  factory :level, class: 'CgtraderLevels::Level' do
    title      { 'First Level' }
    experience { 0 }
    number     { 0 }
    privileges { [create(:privilege)] }
  end
end
