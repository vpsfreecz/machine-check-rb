require 'prometheus/client'
require 'prometheus/client/formats/text'

module MachineCheck
  class Collector
    # @param file [String]
    def self.run(file)
      c = new(file)
      c.run
    end

    # @param file [String]
    def initialize(file)
      @file = file
      @registry = Prometheus::Client.registry
    end

    def run
      [
        Collectors::Sysctl,
        Collectors::Zfs,
      ].each do |klass|
        c = klass.new(registry)
        c.setup
        c.run
      end

      tmp = "#{file}.new"
      
      File.open(tmp, 'w') do |f|
        f.write(Prometheus::Client::Formats::Text.marshal(registry))
      end

      File.rename(tmp, file)
    end

    protected
    attr_reader :file, :registry
  end
end
