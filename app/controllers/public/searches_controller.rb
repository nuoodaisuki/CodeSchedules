class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    range = params[:range]   # 検索対象モデル
    @word = params[:word]     # 検索キーワード

    if @word.blank? 
      redirect_to posts_path, alert: "文字を入力して下さい。"
    else
      if range == "自己紹介文"
        @users = User.looks(params[:word])
      elsif range == "実装機能"
        @posts = Post.looks(params[:word])
      end
    end
  end
  
end
