#! /usr/bin/ruby -w
# -*- coding: utf-8 -*-
# 確率的ハフ変換プログラム
# 2008.03.20 by TOKUHAMA
# 
require 'RMagick'
include Magick
include Math

def houghlines2(img,threshold,theta,lineLength,lineGap,&block)
   #sin,cosの表
   tbl=Array.new(theta){|i| PI/theta*i}.map{|r| [cos(r),sin(r)]}

   width,height=img.columns,img.rows		# [横幅, 高さ]

   target=[]
   #黒い画素を収集
   width.times{|x|
      height.times{|y|
         target << [x, y] if img.pixel_color(x,y).red < 128
      }
   }
   count=target.size

   #メインの処理
   acc=Hash.new(0)
   lines=[]
   count.downto(1){|i|
      #画素をランダムに選択する
      x,y=target.delete_at(rand(i))

      #画素データが更新されているのは除外
      next if img.pixel_color(x,y).red > 128

      #(1) [θ,ρ]空間で集計し、集計値が最大値を取るθを決定
      max_r,max_t=threshold-1,0	  
      theta.times{|t|
         r=(x*tbl[t].first+ y*tbl[t].last).round
         val=(acc[[t,r]] += 1)
         max_r,max_t=val,t if max_r < val
      }

      next if max_r < threshold

      #(2) 追尾用の増分値(dx0,dy0)の設定
      if max_t <= theta/4.0 || max_t >= theta/4.0*3 	#x=ay+b
         dx0,dy0=-tbl[max_t].last/tbl[max_t].first,1		#-sin/cos
      else 	#y=ax+b 
         dx0,dy0=1,-tbl[max_t].first/tbl[max_t].last		#-cos/sin
      end

      #(3) 線分画素を両端方向に追尾し、線分を抽出
      l_e=[[0,0],[0,0]]		#line end
      2.times{|k|
         x0,y0=x,y
         gap=0
         dx0,dy0=-dx0,-dy0 if k > 0		#二度目は方向を逆にする

         loop{
            xt,yt=x0.round,y0.round
            break unless (0..width).include?(xt) && (0..height).include?(yt)

            if img.pixel_color(xt,yt).red < 128
               gap=0
               l_e[k]=[xt,yt]
            else
               break if (gap+=1) > lineGap
            end
	    x0,y0=x0+dx0,y0+dy0
         } 
      }

      #lineLengthより長いものを線分候補とする
      goodLine=(l_e.first[0]-l_e.last[0]).abs>=lineLength
      goodLine||=(l_e.first[1]-l_e.last[1]).abs>=lineLength

      #(4) 追尾した画素を削除し、次回以降は処理されないようにする
      dx0,dy0=-dx0,-dy0
      2.times{|k|
         x0,y0=x,y
         dx0,dy0=-dx0,-dy0 if k > 0

         loop{
            xt,yt=x0.round,y0.round

            if img.pixel_color(xt,yt).red < 128
               if goodLine
                  theta.times{|t|
                     r=(xt*tbl[t].first+ yt*tbl[t].last).round
                     acc[[t,r]] -= 1	#集計値を減らす
                  }
               end
               img.pixel_color(xt,yt,'white')	#画素を更新   
            end

            break if [xt,yt]==[l_e[k].first,l_e[k].last]
			x0,y0=x0+dx0,y0+dy0
         }
      }
      lines << l_e if goodLine
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
   houghlines2(img.dup,50,36,20,10){|p| draw.line(*p) }
   draw.draw(img)
   #img.display
   img.write("tmp.jpg")
   ImageList.new('tmp.jpg').display

   exit
end
