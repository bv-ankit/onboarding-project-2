class ArticlesController < ApplicationController
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
    @article = Article.find(params[:id])
    @user = @article.user
  end
   
  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.create(article_params)

    if @article.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
       
  def update
    @user = User.find(params[:user_id])
    @article = @user.articles.update(article_params)
               
    if @article.update(article_params)
      redirect_to @article
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
           
  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
