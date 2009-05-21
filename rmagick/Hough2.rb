#! /usr/bin/ruby -w
# -*- coding: utf-8 -*-
# 確率的ハフ変換プログラム
# 2008.03.20 by TOKUHAMA
# 2008.03.28 クラス化
 
require 'RMagick'
include Magick
include Math

class Hough2

   def initialize(img,theta,threshold)
      @img,@theta,@threshold=img,theta,threshold

      #sin,cosの表
      @tbl=Array.new(theta){|i| PI/theta*i}.map{|r| [cos(r),sin(r)]}
      @width,@height=img.columns,img.rows            # [横幅, 高さ]

      #源画像から黒色画素を収集
      @target=[]
      @width.times{|x|
         @height.times{|y|
            @target << [x, y] if @img.pixel_color(x,y).red < 128
         }
      }
      @count=@target.size
   end

   #[θ,ρ]空間で集計するためのイテレータ
   def voting(x,y)
      @theta.times{|t|
         r=(x*@tbl[t].first+ y*@tbl[t].last).round
         yield(t,r)
      }
   end
   private :voting

   #線分追尾用のイテレータ
   def trace(x,y,dx,dy)
      2.times{|k|
         x0,y0=x,y
         dx,dy=-dx,-dy if k > 0             #二度目は方向を逆にする
         loop{
            break if yield(k,x0.round,y0.round)
            x0,y0=x0+dx,y0+dy
         }
      }
   end

   #線分の検出
   def detect(lineLength,lineGap,&block)
      @acc=Hash.new(0)
      lines=[]

      @count.downto(1){|i|
         #画素をランダムに選択する
         x,y=@target.delete_at(rand(i))

         #画素データが更新されているのは除外
         next if @img.pixel_color(x,y).red > 128

         #(1) [θ,ρ]空間で集計し、集計値の最大値とそのときのthetaを求める
         max_v,max_t=@threshold-1,0
         voting(x,y){|t,r|
            val=(@acc[[t,r]] += 1)
            max_v,max_t=val,t if max_v < val
         }   
         next if max_v < @threshold

         #(2) 追尾用の増分値(dx,dy)の設定
         c,s=@tbl[max_t].first,@tbl[max_t].last
         dx,dy=(@theta+1...3*@theta).include?(4*max_t)? [1,-c/s] : [-s/c,1]

         #(3) 線分画素を両端方向に追尾し、線分を抽出
         l_e=[[0,0],[0,0]]         #line end
         gap=[0,0]
         trace(x,y,dx,dy){|k,xt,yt|
            next true unless (0...@width).include?(xt) && (0...@height).include?(yt)
            if @img.pixel_color(xt,yt).red < 128
               gap[k]=0
               l_e[k]=[xt,yt]
            else
               next true if (gap[k]+=1) > lineGap
            end
            false
         }

         #lineLengthより長いものを線分候補とする
         goodLine=(l_e.first[0]-l_e.last[0]).abs>=lineLength
         goodLine||=(l_e.first[1]-l_e.last[1]).abs>=lineLength

         #(4) 追尾した画素を削除し、次回以降は処理されないようにする
         trace(x,y,dx,dy){|k,xt,yt|
            if @img.pixel_color(xt,yt).red < 128
               voting(xt,yt){|t,r| @acc[[t,r]] -= 1} if goodLine        #集計値を減らす
               @img.pixel_color(xt,yt,'white')   #画素を更新
            end
            next true if [xt,yt]==l_e[k]
            false
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
end

if __FILE__ == $0
   raise "画像ファイルを引数で指定して下さい" unless ARGV[0]

   p img = ImageList.new(ARGV[0]) #画像の読み込み
   draw=Draw.new
   draw.stroke("red")

   #直線検出・描画
   h=Hough2.new(img.copy,50,36)
   h.detect(20,10) {|p| draw.line(*p) }
   draw.draw(img)
   #img.display
   img.write("tmp.jpg")
   ImageList.new('tmp.jpg').display

   exit
end
