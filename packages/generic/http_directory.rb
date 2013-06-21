require_relative './deployment_user'

package :http_directory do
  requires :deployment_user
  user = fetch(:deployment_user)
  runner 'mkdir /srv/http'
  runner "chown #{user}:#{user} /srv/http"
  runner 'chmod 755 /srv/http'

  verify do
    has_directory '/srv/http'
  end
end
