package :screen, provides: :multiplexer do
  description 'Screen multiplexer'
  apt 'screen', sudo: true

  verify do
    has_apt 'screen'
  end
end
