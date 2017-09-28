
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit show update destroy]
  before_action :require_user, except: [:index, :show]
  # before_action :require_same_user, only: [:edit, :update, :destroy]

  before_action only: [:edit, :update, :destroy] do
    require_same_user(@article.user, 'You can only edit or delete your own article')
  end

  def new
    @article = Article.new
  end

  def create
    # debugger
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to articles_path(@article)
    else
      render 'new'
    end
  end

  def show
    # @article = Article.find(params[:id])
  end

  def edit
    # @article = Article.find(params[:id])
    # changed to a before_action require_same_user
    # redirect_to articles_path unless current_user.eql? @article.user
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def index
    # Using paginate instead of .all to create pages
    # @articles = Article.all
    # @articles = Article.paginate(page: params[:page]) # default is 30, limiting it to 5
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  # def require_same_user
  #   unless current_user.eql? @article.user
  #     flash[:danger] = 'You can only edit or delete your own article'
  #     redirect_to user_path(current_user)
  #   end
  # end
end
