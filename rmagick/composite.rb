require 'RMagick'

gold_fill = Magick::GradientFill.new(0, 0, 0, 0, "#f6e09a", "#cd9245")
dst = Magick::Image.new(128, 128, gold_fill)
src = Magick::Image.read("composite1-src.jpg")[0]
result = dst.composite(src, Magick::CenterGravity, Magick::OverCompositeOp)
result.write('composite1.gif')
