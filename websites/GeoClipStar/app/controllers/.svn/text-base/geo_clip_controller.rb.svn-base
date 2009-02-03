# -*- coding: utf-8 -*-
class GeoClipController < ApplicationController
  caches_page :feed ,:feed_trace, :star_count, :twitter, :map, :index

  # コンテンツ検索API [GET]
  # ksasaoさんが使用する、ジオクリ互換のAPI
  # http://localhost:3000/geo_clip/feed?xxx=yyy&...
  # みたいな感じで呼び出せる
  def feed
=begin
    # 以下、ジオクリAPIの仕様から引用
    params[:keyid] # アクセスキー
    params[:contents_id] # コンテンツID
    params[:search_word] # 検索ワード
    params[:category_cd] # カテゴリコード
    params[:member_id] # ユーザーID
    params[:create_date_from] # 投稿時刻FROM
    params[:create_date_to] # 投稿時刻TO
    params[:latitude] # 緯度
    params[:longitude] # 経度
    params[:range] # 範囲
    params[:sort] # ソート順
    params[:offset] # 検索開始位置
    params[:hit_per_page] # ヒット件数
    params[:offset_page] # 検索開始ページ
=end
    @stars = Star.find(:all, :order => "create_date desc" )
    @stars.each do | star | 
      star.end_flg = star.end_flg.to_s
    end
  end
=begin
  # コンテンツ投稿API [POST]
  def post
  end
=end
  # 位置情報履歴取得API [GET]
  def feed_trace
    @traces = Trace.find(:all, :limit=>100, :order => "create_date desc")
  end
=begin
  # 位置情報書き込みAPI [POST]
  def post_trace
  end
=end

  # get /star_count
  # star数を把握する
  def star_count
    @star_count_all = Star.count
    #TODO: 未回収の条件を入れる
    @star_count_kaisyu_mi = Star.count(:conditions => ["end_flg is null or end_flg = ?", false])
    @star_count_kaisyu_sumi =  @star_count_all && @star_count_kaisyu_mi ? @star_count_all - @star_count_kaisyu_mi : 0
  end

  def twitter
    @twitters = Twitter.find(:all, :limit => 20, :order => "pub_date desc")
  end

  def map
    @flickrs = Flickr.find(:all, :limit => 9, :order => "pub_date desc")
  end

end
