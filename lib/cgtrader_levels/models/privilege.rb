# frozen_string_literal: true

module CgtraderLevels
  class Privilege < ActiveRecord::Base
    enum privilege_type: %i[tax_reduction bonus_coins]

    has_and_belongs_to_many :levels, join_table: 'levels_privileges'
  end
end
