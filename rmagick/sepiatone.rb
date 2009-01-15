# -*- coding: utf-8 -*-
require 'rubygems'
require 'RMagick'

if $0 == __FILE__
  original = ARGV[0]

  unless original
    puts "Usage: ruby #{File.basename(__FILE__)} imagepath"
    exit
  end

  unless FileTest.exists?(original)
    puts "File [%s] not exists" % original
    exit
  end

  # ファイルの読み込み
  img = Magick::ImageList.new(original)
  ext = File.extname(original)

  # 保存用のディレクトリを作成＆ディレクトリに移動
  name = File.basename(original, '.*')
  Dir.mkdir(name) unless FileTest.directory?(name)
  Dir.chdir(name)

  # サイズを倍にする
  img.resize(img.columns * 2, img.rows * 2).write("double#{ext}")

  # 色々やってみる
  methods = %w(sepiatone shade sketch vignette flip flop)
  methods.each { |m| img.__send__(m).write("#{m}#{ext}") }
end
