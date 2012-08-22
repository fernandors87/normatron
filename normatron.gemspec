$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "normatron/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "normatron"
  s.version     = Normatron::VERSION
  s.authors     = ["Fernando Rodrigues da Silva"]
  s.email       = ["fernandors87@hotmail.com"]
  s.homepage    = "https://github.com/fernandors87/normatron"
  s.summary     = "Handle normalization for ActiveRecord attributes"
  s.description = <<-EOF
    Normatron is a Rails plugin that helps normalize ActiveRecord attributes.
    Operations such as lowercase an e-mail address or format a phone number before model validations,
    can be made easily using this plugin.
  EOF

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3.0.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec", ">= 2.0.0"
end
