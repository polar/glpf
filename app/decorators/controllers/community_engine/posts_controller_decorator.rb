PostsController.class_eval do
  def new
    @user = User.friendly.find(params[:user_id])
    @post = Post.new
    if params[:category_id]
      @post.category = Category.find(params[:category_id])
    end
    @post.published_as = 'live'
    @categories = @user.org_teams.map {|x| x.category}
  end

end