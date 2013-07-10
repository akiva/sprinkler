package :git, provides: :scm do
  description 'Git distributed version control'
  apt 'git', sudo: true

  verify do
    has_executable 'git'
  end
end
