class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

  # before_action only: [:edit, :update, :destroy] do
  #   require_same_user(@user, 'You can only edit or delete your own account')
  # end

  before_action -> { require_same_user(@user, 'You can only edit your own account') }, only: [:edit, :update, :destroy]

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to The Rails Framework #{@user.username}"
      redirect_to(user_path(@user))
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to(article_path)
    else
      render 'edit'
    end
  end

  def show
    # @user = User.find(params[:id])
    # added articles variable to enable pagination of articles
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end