require_relative '../packages/debian/ssh'
require_relative '../packages/debian/rsync'
require_relative '../packages/debian/htop'
require_relative '../packages/debian/curl'
require_relative '../packages/debian/wget'
require_relative '../packages/debian/vim'
require_relative '../packages/debian/screen'
require_relative '../packages/debian/tmux'
require_relative '../packages/debian/rxvt_unicode'
require_relative '../packages/debian/git'
require_relative '../packages/debian/mercurial'
require_relative '../packages/debian/svn'

policy :user_tools, roles: :app do
  requires :ssh
  requires :rsync
  requires :htop
  requires :downloader
  requires :vim
  requires :multiplexer
  requires :rxvt_unicode
  requires :scm
end
