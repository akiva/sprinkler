package :svn, provides: :scm do
  description 'Subversion version control'
  apt 'subversion'

  verify do
    has_executable 'svn'
  end
end
