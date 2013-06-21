package :git, provides: :scm do
  description 'Git distributed version control'
  apt 'git'

  verify do
    has_executable 'git'
  end
end
