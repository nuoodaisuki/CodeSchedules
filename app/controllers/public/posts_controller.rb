class Public::PostsController < ApplicationController
    before_action :check_own_post, only: [:show]  # 自分の未了投稿のみ閲覧可能

    def index
      @posts = Post.where(is_completion: true).includes(:task).order(created_at: :desc)
    end
    

    def show
      @post = Post.find(params[:id])
      @user = @post.user
      if @post.is_completion == false && @post.user != current_user
        redirect_to posts_path, alert: "他のユーザーの未了投稿は閲覧できません。"
      end
    end

    def new
      @post = Post.new
      @tasks = Task.all
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to user_path(current_user), notice: "投稿を作成しました。"
      else
        @tasks = Task.all
        render :new
      end
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])
      if @post.user_id == current_user.id && post_params[:is_completion] == "true"
        if @post.update(post_params)
          redirect_to user_path(current_user), notice: '投稿が更新されました'
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to edit_post_path(@post)
      end
    end

    def destroy
      @post = Post.find(params[:id])
    # 自分の投稿かどうか確認
      if @post.user_id == current_user.id
        @post.destroy
        redirect_to user_path(current_user), notice: '投稿を削除しました'
      else
        redirect_to posts_path, alert: '投稿の削除権限がありません'
      end
    end
    

    private

    def post_params
      params.require(:post).permit(:task_id, :time_taken, :note, :is_completion)
    end

    def check_own_post
      @post = Post.find(params[:id])
      return if @post.user == current_user || @post.is_completion?

      redirect_to posts_path, alert: "この投稿を閲覧する権限がありません。"
    end
end
