package :graphicsmagick, provides: :image_processing do
  description 'GraphicsMagick image processing tools'
  apt 'graphicsmagick'

  verify do
    has_apt 'graphicsmagick'
  end
end
