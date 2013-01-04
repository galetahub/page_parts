$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "page_parts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "page_parts"
  s.version     = PageParts::VERSION
  s.authors     = ["Igor Galeta"]
  s.email       = ["galeta.igor@gmail.com"]
  s.homepage    = "https://github.com/galetahub/page_parts"
  s.summary     = "Easy way to setup and use different page parts."
  s.description = "Aimbulance CMS"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "orm_adapter"

  s.add_development_dependency "activerecord", ">= 3.0.0"
  s.add_development_dependency "mongoid"
  s.add_development_dependency "sqlite3"
end
