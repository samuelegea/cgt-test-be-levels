# frozen_string_literal: true

FactoryBot.define do
  factory :privilege, class: 'CgtraderLevels::Privilege' do
    privilege_type { :tax_reduction }
    amount         { 1 }
  end
end
