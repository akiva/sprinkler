package :sphinx, provides: :search do
  description 'Fast standalone full-text SQL search engine'
  apt 'sphinxsearch'
  requires :sphinxbase_utils

  verify do
    has_apt 'sphinxsearch'
  end
end

package :sphinxbase_utils do
  apt 'sphinxbase-utils'

  verify do
    has_apt 'sphinxbase-utils'
  end
end
