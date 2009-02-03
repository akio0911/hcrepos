#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'RMagick'
img = Magick::ImageList.new('test.jpg')
img.resize(200, 200).write('new.jpg')
