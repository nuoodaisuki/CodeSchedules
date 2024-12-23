class Public::GroupUsersController < Public::ApplicationController

  before_action :ensure_guest_user

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer, notice: "参加申請を送りました。"
  end

  def destroy
    # user_id がパラメータに存在する場合はそれを使用（管理者が拒否する場合）
    # 存在しない場合は current_user.id を使用（ユーザーが脱退する場合）
    user_id = params[:user_id] || current_user.id
    
    # group_user を特定
    group_user = GroupUser.find_by(group_id: params[:group_id], user_id: user_id)
  
    # 不正なリクエストや存在しないユーザーへの対策
    if group_user.nil?
      redirect_to group_path(params[:group_id]), alert: "対象のユーザーが見つかりません。"
      return
    end
  
    # オーナーによる拒否処理
    if group_user.group.owner_id == current_user.id
      group_user.destroy
      redirect_to group_path(group_user.group), notice: "参加申請を拒否しました。"
    elsif group_user.user_id == current_user.id
      # ユーザー自身が脱退する処理
      group_user.destroy
      redirect_to groups_path, notice: "グループから脱退しました。"
    else
      redirect_to group_path(group_user.group), alert: "権限がありません。"
    end
  end
    


  def update
    group_user = GroupUser.find(params[:id])
  
    # 承認処理はグループ作成者のみ実行可能
    if group_user.group.owner == current_user
      group_user.update(is_participation: true) # 参加ステータスをtrueにする
      redirect_to group_path(group_user.group), notice: "参加申請を承認しました。"
    else
      redirect_to request.referer, alert: "承認権限がありません。"
    end
  end
  

  private

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , alert: "ゲストユーザーはグループ機能を使えません。"
    end
  end
end
