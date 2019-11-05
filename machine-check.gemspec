lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'machine-check/version'

Gem::Specification.new do |s|
  s.name        = 'machine-check'
  s.version   = MachineCheck::VERSION

  s.summary       =
  s.description   = 'Export machine parameters to node_exporter'
  s.authors       = 'Jakub Skokan'
  s.email         = 'jakub.skokan@vpsfree.cz'
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.license       = 'Apache-2.0'

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'prometheus-client', '~> 0.9.0'
  s.add_runtime_dependency 'require_all', '~> 2.0.0'
  s.add_development_dependency 'rake'
end
