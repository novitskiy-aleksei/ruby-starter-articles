class PaginateArticles

  def initialize(model)
    @model = model
    @current_page = 0
  end

  def call(offset, limit)
    @model.all.offset(offset).limit(limit)
  end

  private

  def foo

  end
end
