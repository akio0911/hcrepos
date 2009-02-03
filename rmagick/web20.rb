# -*- coding: utf-8 -*-
require 'RMagick'
include Magick

WIDTH = 650
HEIGHT = 40

# 画像リストを作成
stripes = ImageList.new

# グラデーションを作成
top_grad = GradientFill.new(0, 0, WIDTH, 0, "#dddddd", "#888888")
# グラデーション画像を作成
image1 = Image.new(WIDTH, HEIGHT, top_grad)
# グラデーション画像を保存
image1.write('image1.png')
# グラデーション画像をリストに追加
stripes << image1


# グラデーションを作成
bottom_grad = GradientFill.new(0, 0, WIDTH, 0, "#757575", "#555555")
# グラデーション画像を作成
image2 = Image.new(WIDTH, HEIGHT, bottom_grad)
# グラデーション画像を保存
image2.write('image2.png')
# グラデーション画像をリストに追加
stripes << image2

# 画像を上下方向に連結
combined_grad = stripes.append(true)
# 連結した画像を保存
combined_grad.write('image3.png')

# 連結した画像を複製
image4 = combined_grad.clone
# 文字列を描画
gc = Draw.new
gc.font = '/Library/Fonts/ヒラギノ明朝 Pro W3.otf'
gc.fill = 'white'
gc.stroke = 'none'
gc.pointsize = 60
gc.annotate(image4, 0, 0, 10, 60, "Do Ruby!")
# 文字列を描画した画像を保存
image4.write('image4.png')
