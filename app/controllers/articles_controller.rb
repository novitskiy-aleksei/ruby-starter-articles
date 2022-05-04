# Articles
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    skip_authorization
    @page = params[:page].to_i
    @page = 1 if @page <= 0

    @per_page = 15
    @articles = PaginateArticles.new(Article).call((@page - 1) * @per_page, @per_page)

    @options = {
      total_pages: Article.all.count / @per_page,
      current_page: @page
    }
  end

  def index_my
    skip_authorization # ?

    @page = 1
    @per_page = 100
    @articles = policy_scope(Article).all

    @options = {
      total_pages: Article.all.count / @per_page,
      current_page: @page
    }

    render 'index'
  end

  def show
    skip_authorization
    @article = Article.find(params[:id])
  end

  def new
    skip_authorization
    @article = Article.new
  end

  def create
    skip_authorization
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      ActionCable.server.broadcast(:articles_channel, { id: @article.id, title: @article.title })
      PdfGenerationJob.perform_later @article.id, { host: request.host }
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    authorize @article, :update?
  rescue Pundit::NotAuthorizedError
    redirect_to @article, alert: "You have no permission to edit other author's articles"
  end

  def update
    @article = authorize Article.find(params[:id])

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
