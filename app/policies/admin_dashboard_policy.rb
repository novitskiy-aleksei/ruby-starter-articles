class AdminDashboardPolicy < ApplicationPolicy
  def dashboard?
    true
  end
  def index?
    true
  end
  def show?
    true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      AdminUser.all
    end

    private

    attr_reader :user, :scope
  end
end
