class PostPolicy < ApplicationPolicy
  # NOTE: Be explicit about which records you allow access to!
  def resolve
    scope.all
  end
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end

    private

    attr_reader :user, :scope
  end

  def update?
    user.admin? or not record.published?
  end
end
