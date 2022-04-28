# Articles
class ArticlesController < ApplicationController
  def index
    @page = params[:page].to_i
    @page = 1 if @page <= 0

    @per_page = 15
    @articles = PaginateArticles.new(Article).call((@page - 1) * @per_page, @per_page)

    @options = {
      total_pages: Article.all.count / @per_page,
      current_page: @page
    }
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
