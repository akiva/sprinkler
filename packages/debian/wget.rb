package :wget, provides: :downloader do
  description 'wget'
  apt 'wget', sudo: true

  verify do
    has_apt 'wget'
  end
end
