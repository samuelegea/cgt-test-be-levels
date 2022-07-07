# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'CgtraderLevels::User' do
    username { 'John' }
    reputation { 0 }
    coins { 0 }
  end
end
