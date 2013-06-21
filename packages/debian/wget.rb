package :wget, provides: :downloader do
  description 'wget'
  apt 'wget'

  verify do
    has_apt 'wget'
  end
end
