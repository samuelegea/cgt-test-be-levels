# frozen_string_literal: true

module CgtraderLevels
  class Level < ActiveRecord::Base
    has_many :users, class_name: 'CgtradersLevels::User'
    has_and_belongs_to_many :privileges, join_table: 'levels_privileges'

    after_create :create_privilege_coins

    def levelup_reward_coins
      privileges.where(privilege_type: :level_up_coins).pluck(:amount).compact.sum
    end

    private

    def create_privilege_coins
      privileges.create! privilege_type: :level_up_coins, amount: coins_bonuses
    end

    # Likely will change in the future
    def coins_bonuses(qtd = number)
      # Study logarithim approaches, for better easing in higher levels, such as
      # Math.log(number).floor*CONST
      qtd * 5
    end
  end
end
