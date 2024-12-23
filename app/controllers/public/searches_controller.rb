class Public::SearchesController < Public::ApplicationController

  def search
    range = params[:range]   # 検索対象モデル
    @word = params[:word]     # 検索キーワード

    if @word.blank? 
      redirect_to posts_path, alert: "文字を入力して下さい。"
    else
      case range
      when "実装機能"
        @posts = Post.looks(params[:word])
      when "グループの作成者名"
        @groups = Group.search_by_owner_name(params[:word])
      when "グループメンバー名"
        @groups = Group.search_by_member_name(params[:word])
      end
    end
  end
  
end
