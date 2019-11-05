module MachineCheck
  class Cli
    def self.run
      if ARGV.length != 1
        warn "Usage: #{$0} <file>"
        exit(false)
      end

      MachineCheck::Collector.run(ARGV[0])
    end
  end
end
