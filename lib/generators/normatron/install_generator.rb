module Normatron
  ##
  # Creates all necessary files to run Normatron in your Ruby On Rails project.
  #
  # These files are:
  # * config/initializers/normatron.rb
  #
  # *Usage:*
  #   $ rails generator normatron:install
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc "Create all necessary files to run Normatron in your Ruby On Rails project."

    ##
    # Copy files from templates to their respective destination
    #
    # These files are:
    # * config/initializers/normatron.rb
    def copy_files
      copy_file "normatron.rb", "config/initializers/normatron.rb"
    end
  end
end