class CgtraderLevels::User < ActiveRecord::Base

  belongs_to :level, class_name: 'CgtraderLevels::Level', foreign_key: 'level_id'

  after_save :set_new_level

  def tax_with_level_bonuses
    tax - level.privileges.where(privilege_type: :tax_reduction).sum(:amount)
  end

  private

  def set_new_level
    return unless matching_level

    increase_level_bonus_coins if level_up?

    update_column :level_id, matching_level.id
  end

  def matching_level
    CgtraderLevels::Level.where('experience <= ?', reputation).order(experience: :desc).first
  end

  def increase_level_bonus_coins
    self.class.update_counters id, coins: 7
  end

  def level_up?
    matching_level.experience > (level&.experience || 0)
  end
end
