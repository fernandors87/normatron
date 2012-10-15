module Normatron
  ##
  # Creates all necessary files to run Normatron in your Ruby On Rails project.
  #
  # Even when required, Normatron doesn't include his functionalities into your ORM automatically.
  # It behaves this way to avoid some potential issues.
  #
  # Using this generator, you can get fully control of Normatron behavior through initialization file.
  #
  # These files includes:
  # * config/initializers/normatron.rb
  #
  # h2. Usage
  #   
  # pre. $ rails generator normatron:install
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Create all necessary files to run Normatron in your Ruby On Rails project."

    ##
    # Copy files from templates to their respective destination.
    #
    # These files includes:
    # * config/initializers/normatron.rb
    def copy_files
      copy_file "normatron.rb", "config/initializers/normatron.rb"
    end
  end
end