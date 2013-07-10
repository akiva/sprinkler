package :monit, provides: :monitoring do
  description 'Monit process monitoring'
  apt 'monit', sudo: true
end
