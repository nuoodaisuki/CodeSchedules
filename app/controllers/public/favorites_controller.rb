class Public::FavoritesController < Public::ApplicationController

  before_action :set_post, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

end
