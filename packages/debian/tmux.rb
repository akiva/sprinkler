package :tmux, provides: :multiplexer do
  description 'TMUX multiplexer'
  apt 'tmux', sudo: true

  verify do
    has_apt 'tmux'
  end
end
