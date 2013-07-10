package :htop do
  description 'htop interactive processes viewer'
  apt 'htop', sudo: true

  verify do
    has_executable 'htop'
  end
end
