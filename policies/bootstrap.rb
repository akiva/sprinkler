require_relative '../packages/generic/deployment_user'

policy :bootstrap, roles: :server do
  requires :deployment_user
end
