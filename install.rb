directories = {
  config: File.join(File.dirname(__FILE__), 'config'),
  policies: File.join(File.dirname(__FILE__), 'policies'),
  packages: File.join(File.dirname(__FILE__), 'packages'),
  assets: File.join(File.dirname(__FILE__), 'assets'),
}

require File.join(directories[:config], 'capistrano_variables')

# Policies list, default to "base"
POLICIES = Array(ARGV[0..-1])
POLICIES << 'base' if POLICIES.empty?

# Aborts if any invalid policies are specified,
lambda { |policies, policy_dir|
  valid_policies = Dir.glob(File.join(policy_dir, '*.rb')).collect do |e|
    File.basename(e, '.rb')
  end

  invalid_policies = policies - valid_policies

  unless invalid_policies.empty?
    puts "Invalid policy/policies specified: #{invalid_policies.join(', ')}."
    puts "Available policies are: #{valid_policies.join(', ')}."
    exit(1)
  end
}.call(POLICIES, directories[:policies])

# Require_relative doesn't work in this context
POLICIES.each { |policy| require File.join(directories[:policies], policy) }

deployment do
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'config/deploy'
    end

    # Since some sprinkle installers (push_text, replace_text especially) do
    # not use capistrano sudo password prompt, hack capistrano to use default
    # sudo prompt (it may work since we know deploy user) and hope  capistrano
    # will catch most sudo password requests.
    # see https://github.com/crafterm/sprinkle/issues/42
    set :sudo_prompt, "[sudo] password for #{fetch(:deploy_user, fetch(:user))}:"

  end
end
