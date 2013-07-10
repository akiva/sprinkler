package :ruby_rbenv do
  description 'Install rbenv and Ruby version of choice'
  requires :ruby_essentials,
           :use_rbenv,
           :install_ruby,
           :update_rubygems,
           :install_bundler
end

package :ruby_essentials do
  description 'Ruby essentials'
  apt 'libssl-dev zlib1g zlib1g-dev libreadline-dev', sudo: true
end

package :update_rubygems do
  description 'Update RubyGems package management system'
  runner '~/.rbenv/shims/gem update --system'
end

package :use_rbenv do
  description 'Sets global Ruby version via rbenv'
  requires :install_rbenv
  push_text 'export PATH="$HOME/.rbenv/bin:$PATH"', '~/.profile'
  push_text 'eval "$(rbenv init -)"', '~/.profile'

  verify do
    file_contains '~/.profile', 'rbenv'
    has_executable '~/.rbenv/bin/rbenv'
  end
end

package :install_rbenv do
  description 'Install rbenv, Ruby version manager'
  runner 'git clone git://github.com/sstephenson/rbenv.git ~/.rbenv',
         'git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build'

  verify do
    has_executable '~/.rbenv/bin/rbenv'
  end
end

package :install_ruby do
  description 'Install Ruby version of choice via rbenv'
  version = fetch(:ruby_version)
  runner '~/.rbenv/bin/rbenv rehash'
  runner "~/.rbenv/bin/rbenv install #{version}"
  runner '~/.rbenv/bin/rbenv rehash'
  runner "~/.rbenv/bin/rbenv global #{version}"

  verify do
    has_executable '~/.rbenv/shims/ruby'
  end
end

package :install_bundler do
  description 'Install Bundler gem'
  runner '~/.rbenv/shims/gem install bundler --no-rdoc --no-ri'
  runner '~/.rbenv/bin/rbenv rehash'

  verify do
    has_executable '~/.rbenv/shims/bundle'
  end
end
