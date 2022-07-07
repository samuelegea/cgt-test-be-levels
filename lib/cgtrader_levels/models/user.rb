# frozen_string_literal: true

module CgtraderLevels
  class User < ActiveRecord::Base
    belongs_to :level, class_name: 'CgtraderLevels::Level', foreign_key: 'level_id'

    before_save :set_new_level
    delegate :privileges, to: :level

    def tax_with_level_bonuses
      tax - privileges.where(privilege_type: :tax_reduction).sum(:amount)
    end

    private

    def set_new_level
      return unless matching_level || !reputation_changed?

      increment :coins, coin_rewards(levels_passed) if level_up? || reputation.zero?
      self.level = matching_level
    end

    def matching_level
      CgtraderLevels::Level.where(experience: ..reputation).order(number: :desc).first
    end

    def coin_rewards(levels_passed)
      levels_passed.sum(&:levelup_reward_coins)
    end

    def levels_passed
      CgtraderLevels::Level.where(experience: ..reputation).select { |new_level| new_level.number > current_level_number }
    end

    def qtd_levels_passed
      matching_level.number - current_level_number
    end

    def level_up?
      qtd_levels_passed.positive?
    end

    def current_level_number
      level&.number || 0
    end
  end
end
