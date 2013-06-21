package :screen, provides: :multiplexer do
  description 'Screen multiplexer'
  apt 'screen'

  verify do
    has_apt 'screen'
  end
end
