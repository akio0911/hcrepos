# -*- coding: utf-8 -*-
require 'rubygems'
require 'RMagick'
include Magick
include Math

src = Magick::Image.read("test.jpg")[0]
p src.columns
p src.rows

width,height=src.columns,src.rows		# [横幅, 高さ]

target=[]
#黒い画素を収集
width.times{|x|
  height.times{|y|
#    target << [x, y] if src.pixel_color(x,y).red < 256*10
    p src.pixel_color(x,y).red
  }
}
count=target.size
p count

