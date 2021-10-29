require_relative "lib/nilpart/version"

Gem::Specification.new do |s|
  s.name        = 'nilpart'
  s.version     = Nilpart::VERSION
  s.summary     = "Partoo Api Connector"
  s.description = "Nilpart allow you to connect to Partoo RestAPI !"
  s.authors     = ["Sylvain Claudel"]
  s.email       = 'claudel.sylvain@gmail.com'

  all_files     = `git ls-files`.split("\n").reject{ |filepath| filepath.start_with? 'test/' }
  s.files       = all_files

  s.require_paths = ["lib/nilpart"]

  s.homepage    = 'https://rubygems.org/gems/nilpart'
  s.license     = 'MIT'

  s.add_runtime_dependency("faraday")
end
