# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  view_count :integer          default(0)
#

class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :search]
  before_action :set_markdown, only: [:index, :show, :search]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
    @title = @articles.length > 0 ? 'All Articles' : 'There is no article'
  end

  def show
    if params[:show]
      @article.increase_view_count
    end
    @comments = @article.comments
  end

  def search
    if params[:title].blank?
      @title = 'Your keyword is empty'
      @articles = []
    else
      @articles = Article.where('lower(title) LIKE :query', query: "%#{params[:title].downcase}%")
      @title = @articles.length > 0 ? 'Search result' : 'There is no article'
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed'
  end

  private
  def set_markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
