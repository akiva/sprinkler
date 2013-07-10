# Sprinkler bootstrap script

# This script is specific to the initial bootstrap process, which will
# set up the deployment user to be used herein after

# Allow for packages to be able to read Capistrano variables
require File.join(File.dirname(__FILE__), 'config', 'capistrano_variables')

# Load our bootstrap policy
require File.join(File.dirname(__FILE__), 'policies', 'bootstrap.rb')

# Deployment

deployment do
  delivery :capistrano do
    begin
      load 'config/bootstrap'
      default_run_options[:pty] = true
      ssh_options[:compression] = false
    rescue LoadError
      recipes 'config/bootstrap'
    end
  end
end
