# frozen_string_literal: true

require_relative './cgtrader_levels/version'

module CgtraderLevels
  autoload :User, 'cgtrader_levels/models/user'
  autoload :Level, 'cgtrader_levels/models/level'
  autoload :Privilege, 'cgtrader_levels/models/privilege'
end
