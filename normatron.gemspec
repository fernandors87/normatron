$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "normatron"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "normatron"
  s.version     = Normatron::VERSION
  s.authors     = ["Fernando Rodrigues da Silva"]
  s.email       = ["fernandors87@gmail.com"]
  s.homepage    = "https://github.com/fernandors87/normatron"
  s.summary     = "Normalize attributes for ActiveRecord objects."
  s.description = <<-EOF
    Normatron is an attribute normalizer for ActiveRecord objects.
    With it you can convert attributes to the desired format before saving them in the database.
    This gem inhibits the work of having to override attributes or create a specific method to perform most of the normalizations.
  EOF

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.textile"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "activerecord", ">= 3.2.0"
  s.add_dependency "activesupport", ">= 3.2.0"

  s.add_development_dependency "sqlite3", ">= 1.3.0"
  s.add_development_dependency "rspec", ">= 2.10.0"
end
