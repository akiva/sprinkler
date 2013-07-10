package :rsync do
  description 'Rsync'
  apt 'rsync', sudo: true

  verify do
    has_apt 'rsync'
  end
end
