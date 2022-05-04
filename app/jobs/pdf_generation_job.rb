class PdfGenerationJob < ApplicationJob
  queue_as :default

  # O_O
  # ArgumentError (You are passing an instance of ActiveRecord::Base to `find`. Please pass the id of the object by calling `.id`.):

  def perform(article_id, url_options)
    @article = Article.find(article_id)

    controller = ArticlesController.new
    controller.request = ActionDispatch::Request.new({
      'REQUEST_METHOD' => 'GET',
      'HTTP_HOST' => url_options[:host]
    })

    manager = Warden::Manager.new(nil, &Rails.application.config.middleware.detect{|m| m.name == 'Warden::Manager'}.block)
    controller.request.env['warden'] = Warden::Proxy.new(controller.request.env, manager)

    html = controller.render_to_string({
                                               template: 'articles/show',
                                               layout: 'application',
                                               locals: { :@article => @article }
                                             })
    pdf = Grover.new(html).to_pdf
    @article.pdf.attach(io: StringIO.new(pdf), filename: "#{@article.title}.pdf", content_type: "application/pdf")
  end
end
