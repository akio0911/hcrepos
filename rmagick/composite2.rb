require 'RMagick'

dst = Magick::Image.read("plasma:fractal") { self.size = "128x128"}.first
src = Magick::Image.read('tux.gif').first
result = dst.composite(src, Magick::CenterGravity, Magick::OverCompositeOp)
result.write('composite2.gif')
