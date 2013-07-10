package :sphinx, provides: :search do
  description 'Shinx is a fast standalone full-text SQL search engine'
  apt 'sphinxsearch', sudo: true
  requires :sphinxbase_utils

  verify do
    has_apt 'sphinxsearch'
  end
end

package :sphinxbase_utils do
  description 'Sphinx base utilities'
  apt 'sphinxbase-utils', sudo: true

  verify do
    has_apt 'sphinxbase-utils'
  end
end
