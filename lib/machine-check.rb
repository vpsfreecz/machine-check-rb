require 'require_all'

module MachineCheck
  module Collectors ; end
end

require_rel 'machine-check/*.rb'
require_rel 'machine-check/collectors/*'
