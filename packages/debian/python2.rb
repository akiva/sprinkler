package :python2 do
  description 'Python v2.7'
  apt 'python2.7', sudo: true

  verify do
    has_executable 'python2'
  end
end
