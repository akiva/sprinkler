package :htop do
  apt 'htop'

  verify do
    has_executable 'htop'
  end
end
