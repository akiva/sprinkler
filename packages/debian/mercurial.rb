package :mercurial, provides: :scm do
  description 'Mercurial version control'
  apt 'mercurial', sudo: true

  verify do
    has_executable 'hg'
  end
end
