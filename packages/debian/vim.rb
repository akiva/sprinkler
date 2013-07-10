package :vim do
  description 'Vi IMproved - enhanced vi editor'
  apt 'vim', sudo: true
  requires :vimrc

  verify do
    has_apt 'vim'
  end
end

package :vimrc do
  description 'Installs system-wide Vim config file'
  system_vimrc = '/etc/vim/vimrc.local'
  template = File.join(Dir.pwd, 'assets', 'vimrc')
  transfer template, system_vimrc, sudo: true

  verify do
    has_file system_vimrc
  end
end
