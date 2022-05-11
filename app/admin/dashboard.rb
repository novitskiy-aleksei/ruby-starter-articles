# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  def index
    authorize :dashboards, :index?
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    #
    ##
    columns do
      column do
        panel "Recent Articles" do
          ul do
            Article.all.order(:created_at).map do |article|
              li link_to(article.title, article_path(article))
            end
          end
        end
      end

      column do
        panel "Authors" do
          ul do
            User.all.map do |user|
              li user.email
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end
end
