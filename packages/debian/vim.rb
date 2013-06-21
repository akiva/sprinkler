package :vim do
  description 'vim'
  apt 'vim'
  requires :vimrc

  verify do
    has_apt 'vim'
  end
end

package :vimrc do
  description 'Installs system-wide /etc/vimrc'
  system_vimrc = '/etc/vim/vimrc.local'
  template = File.join(Dir.pwd, 'assets', 'vimrc')
  transfer template, system_vimrc

  verify do
    has_file system_vimrc
  end
end
