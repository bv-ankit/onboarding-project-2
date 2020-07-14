class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:create, :edit, :update, :destroy, :index, :new]
  before_action :correct_user, only: [:create, :index, :new]
  before_action :correct_user_edit, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
  end

  def edit
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.create(article_params)

    if @article.save
      redirect_to user_article_path(@user, @article)
    else
      flash.now[:danger] = "ERROR: Minimum length of title is 4 char & body is 10 char."
      render "new"
    end
  end

  def update
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    if @user && @article
      if @article.update_attributes(article_params)
        redirect_to user_article_path(@user, @article)
      else
        flash.now[:danger] = "ERROR: Minimum length of title is 4 char & body is 10 char."
        render "edit"
      end
    else
      flash.now[:danger] = "Article not found."
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    @article.destroy
    redirect_to user_path(@user)
  end

  def feed
    @article = Article.all
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def correct_user
    redirect_to root_path unless current_user?(User.find(params[:user_id]))
    @article = current_user.articles.find_by(id: params[:id])
  end

  def correct_user_edit
    correct_user
    @article = current_user.articles.find_by(id: params[:id])
    redirect_to root_path if @article.nil?
  end
end
