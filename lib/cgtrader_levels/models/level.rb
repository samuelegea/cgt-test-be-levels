# frozen_string_literal: true

module CgtraderLevels
  class Level < ActiveRecord::Base
    has_many :users, class_name: 'CgtradersLevels::User'
    has_and_belongs_to_many :privileges, join_table: 'levels_privileges'
  end
end
