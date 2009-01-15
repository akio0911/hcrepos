# -*- coding: utf-8 -*-
require 'RMagick'

path = 'test.jpg'
img = Magick::ImageList.new(path)

p img.columns #=> 横幅
p img.rows #=> 高さ

width = 100 #横幅
height = 80 #高さ
img.resize(width, height)

width = 100
height = (img.rows.to_f * width.to_f / img.columns.to_f).to_i
img.resize(width, height)

p width
p height

amount = 90 #角度(時計回り)
new_img = img.rotate(amount)
new_img.write('rotate.jpg')
