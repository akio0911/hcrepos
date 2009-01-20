# -*- coding: utf-8 -*-
# RMagick で30度回転するサンプル
require 'rubygems'
require 'RMagick'

src = Magick::Image.read("test.jpg")[0]
amount = 30
new_img = src.rotate(amount)
new_img.write('output.png')

