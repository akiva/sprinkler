package :rxvt_unicode do
  description 'Multi-lingual terminal emulator with Unicode support'
  apt 'rxvt-unicode-256color', sudo: true

  verify do
    has_apt 'rxvt-unicode-256color'
  end
end
