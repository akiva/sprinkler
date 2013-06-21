package :tmux, provides: :multiplexer do
  description 'TMUX multiplexer'
  apt 'tmux'

  verify do
    has_apt 'tmux'
  end
end
