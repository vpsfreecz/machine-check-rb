require 'machine-check/collectors/base'

module MachineCheck
  class Collectors::Zfs < Collectors::Base
    def setup
      @zpool_list_success = registry.gauge(
        :zpool_list_success,
        docstring: 'Process exit code',
      )
      @zpool_list_parse_success = registry.gauge(
        :zpool_list_parse_success,
        docstring: 'Parsing successful',
      )
      @zpool_list_health = registry.gauge(
        :zpool_list_health,
        docstring: 'Pool healthy',
        labels: [:name],
      )
      @zpool_list_fragmentation = registry.gauge(
        :zpool_list_fragmentation,
        docstring: 'Pool fragmentation',
        labels: [:name],
      )
      @zpool_list_capacity = registry.gauge(
        :zpool_list_capacity,
        docstring: 'Pool capacity',
        labels: [:name],
      )
    end

    def run
      list = `zpool list -Hp -o name,health,fragmentation,capacity`

      if $?.exitstatus != 0
        @zpool_list_success.set(1)
        return
      end

      @zpool_list_success.set(0)
      @zpool_list_parse_success.set(0)
      
      list.split("\n").each do |line|
        name, health, fragmentation, capacity = line.split

        @zpool_list_health.set(health == 'ONLINE' ? 0 : 1, labels: {name: name})
        @zpool_list_fragmentation.set(fragmentation.to_i, labels: {name: name})
        @zpool_list_capacity.set(capacity.to_i, labels: {name: name})
      end
    end
  end
end
