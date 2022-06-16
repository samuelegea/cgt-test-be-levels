class CgtraderLevels::User < ActiveRecord::Base
  attr_reader :level

  after_save :set_new_level

  private

  def set_new_level
    return unless matching_level

    self.level_id = matching_level.id
    @level = matching_level
  end

  def matching_level
    CgtraderLevels::Level.where('experience <= ?', reputation).order(experience: :desc).first
  end
end
