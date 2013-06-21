package :mercurial, provides: :scm do
  description 'Mercurial version control'
  apt 'mercurial'

  verify do
    has_executable 'hg'
  end
end
