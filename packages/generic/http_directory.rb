package :http_directory do
  description 'Create HTTP directory for deploying Web apps'
  user = fetch(:user)
  runner 'sudo mkdir /srv/http'
  runner "sudo chown #{user}:#{user} /srv/http"
  runner 'sudo chmod 755 /srv/http'

  verify do
    has_directory '/srv/http'
  end
end
