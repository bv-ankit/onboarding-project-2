class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:create, :edit, :update, :destroy, :index, :new]
  before_action :correct_user, only: [:edit, :update, :destroy]

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
      render 'new'
    end
  end
       
  def update
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
    if @user && @article 
      @article.update_attributes(article_params)
      redirect_to user_article_path(@user, @article)
    else
      render 'edit'
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
    if current_user?(User.find_by(id: params[:id]))
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    else
      redirect_to root_url
    end
  end
end
