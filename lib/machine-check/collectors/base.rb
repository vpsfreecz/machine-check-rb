module MachineCheck
  class Collectors::Base
    def initialize(registry)
      @registry = registry
    end

    protected
    attr_reader :registry
  end
end
