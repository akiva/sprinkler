require_relative '../packages/generic/rbenv'

policy :test, roles: :app do
  requires :rbenv
end
