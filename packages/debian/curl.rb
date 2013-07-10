package :curl, provides: :downloader do
  description 'Curl'
  apt 'curl', sudo: true

  verify do
    has_apt 'curl'
  end
end
