require 'machine-check/collectors/base'

module MachineCheck
  class Collectors::Sysctl < Collectors::Base
    def setup
      @sysctl_kernel_keys_maxkeys = registry.gauge(
        :sysctl_kernel_keys_maxkeys,
        docstring: 'Value of /proc/sys/kernel/keys/maxkeys',
      )
      @sysctl_kernel_keys_maxbytes = registry.gauge(
        :sysctl_kernel_keys_maxbytes,
        docstring: 'Value of /proc/sys/kernel/keys/maxbytes',
      )
    end

    def run
      @sysctl_kernel_keys_maxkeys.set(File.read('/proc/sys/kernel/keys/maxkeys').strip.to_i)
      @sysctl_kernel_keys_maxbytes.set(File.read('/proc/sys/kernel/keys/maxbytes').strip.to_i)
    end
  end
end
