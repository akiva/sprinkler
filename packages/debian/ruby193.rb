package :ruby193 do
  description 'Install system Ruby 1.9.3 interpreter and bundler'
  requires :ruby_dependencies

  apt 'ruby1.9.3', sudo: true do
    post :install, 'gem install bundler'
    post :install, 'gem update'
  end

  verify do
    has_apt 'ruby1.9.3'
    has_gem 'bundler'
  end
end

package :ruby_dependencies do
  description 'Ruby build dependencies'
  apt %w( bison zlib1g-dev libssl-dev libncurses5-dev file ), sudo: true
end
