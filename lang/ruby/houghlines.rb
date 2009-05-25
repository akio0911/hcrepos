#! /usr/bin/ruby -w
# -*- coding: utf-8 -*-
# 標準ハフ変換
# 2008.03.16 by TOKUHAMA
#
require 'rubygems'
require 'RMagick'
include Magick
include Math

def houghlines(img,threshold,theta=180,&block)
   #sin,cosの表
   tbl=Array.new(theta){|i| PI/theta*i}.map{|r| [cos(r),sin(r)]}

   size=[img.columns, img.rows]         # [横幅, 高さ]
   acc=Hash.new(0)

   #[x-y]座標値からρを求めて、[θ-ρ]空間でカウント
   size.first.times{|x|
      size.last.times{|y|
         next if img.pixel_color(x,y).red > 128 #ピクセルが白に近いものはスキップ
         theta.times{|t|
            r=(x*tbl[t].first+ y*tbl[t].last).round
            acc[[t,r]] += 1 
         }
      }
   }

   #カウント値の降順で並べ替え
   acc_s=acc.reject{|x,y| y<threshold}.sort{|x,y| y[1]<=>x[1]}

   lines=[]
   #逆変換と描線の座標値[始点x,始点y,終点x,終点y]を生成
   acc_s.collect{|k,d| k}.each{|t,r|
      #算出する直線の式(x=ay+b or y=ax+b)を決定
      k = (t<=theta/4.0 || t>=theta/4.0*3)? 0 : 1       #x=ay+b : y=ax+b
      n,d = tbl[t][k-1],tbl[t][k]
      a,b = -n/d, r/d
      s=size[k-1]       #columns or rows

      #x=ay+b型で座標値を算出
      lines << if a == 0 then [[b,0],[b,s]]
               elsif a > 0 then [[0,-b/a],[a*s+b,s]]
               else [[0,-b/a],[b,0]] end
      #y=ax+b型のとき、xとyを入れ替え
      lines[-1].map!{|p| [p.last,p.first]} if k==1  
   }

   #ブロックの実行または描線用の座標値を返す
   if block
      lines.each{|l| yield(l.flatten)}
   else
      return lines
   end
end

if __FILE__ == $0
   raise "画像ファイルを引数で指定して下さい" unless ARGV[0]

   p img = ImageList.new(ARGV[0]) #画像の読み込み
   draw=Draw.new
   draw.stroke("red")

   #直線検出・描画
   houghlines(img,50,36){|p| draw.line(*p) }
   draw.draw(img)
   #img.display
   img.write("tmp.jpg")
#   ImageList.new('tmp.jpg').display

   exit
end
