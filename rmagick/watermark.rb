# -*- coding: utf-8 -*-
require 'RMagick'

if !ARGV[0]
    puts "Usage: watermark <path-to-image>"
    exit
end

image = Magick::Image.read(ARGV[0]).first

mark = Magick::Image.new(image.columns, image.rows)

gc = Magick::Draw.new
gc.gravity = Magick::CenterGravity
gc.pointsize = 32
gc.font = '/Library/Fonts/ヒラギノ明朝 Pro W3.otf'
gc.stroke = 'none'
gc.annotate(mark, 0, 0, 0, 0, "Watermark\nby\nRMagick")

mark = mark.shade(true, 310, 30)

image.composite!(mark, Magick::CenterGravity, Magick::HardLightCompositeOp)

out = ARGV[0].sub(/\./, "-wm.")
puts "Writing #{out}"
image.write(out)
