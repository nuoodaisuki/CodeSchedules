class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    range = params[:range]   # 検索対象モデル
    @word = params[:word]     # 検索キーワード

    if @word.blank? 
      redirect_to posts_path, alert: "文字を入力して下さい。"
    else
      case range
      when "自己紹介文"
        @users = User.looks(params[:word])
      when "実装機能"
        @posts = Post.looks(params[:word])
      when "グループの作成者の苗字か名前"
        @groups = Group.search_by_owner_name(params[:word])
      when "グループメンバーの苗字か名前"
        @groups = Group.search_by_member_name(params[:word])
      end
    end
  end
  
end
