class Public::GroupsController < Public::ApplicationController

  before_action :ensure_guest_user
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.includes(:group_users).all
    @user = User.find(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group), notice: "グループを作成しました。"
    else
      flash.now[:alert] = "グループ名を入力して下さい。"
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループ情報を更新しました。"
    else
      flash.now[:alert] = "グループ名を入力してください。"
      render :edit
    end
  end

  def pending_users
    @group = Group.find(params[:id])
    if @group.owner_id == current_user.id
      @pending_users = @group.group_users.includes(:user).where(is_participation: false)
    else
      redirect_to group_path(@group), alert: "権限がありません。"
    end
  end

  def members
    @group = Group.find(params[:id])
    @members = @group.group_users.includes(:user).where(is_participation: true) # GroupUserを経由してユーザーを取得
  end
  
  private

    def group_params
      params.require(:group).permit(:name, :explanation, :group_image)
    end

    def ensure_guest_user
      @user = current_user
      if @user.email == "guest@example.com"
        redirect_to user_path(current_user) , alert: "ゲストユーザーはグループ機能を使えません。"
      end
    end

    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path , alert: "グループ名・紹介文の編集はグループの作成者しか行えません。"
      end
    end
end
