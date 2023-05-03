class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    # .role is used for using enum

    @user.role == 'admin'
    # @user.has_role? :admin
  end

  def edit?
    # @user.has_role? :admin
    @user.role == 'admin'
  end

  def update?
    #  .has_role used for using rolify
    @user.role == 'admin'
    # @user.has_role? :admin
  end

  def destroy?
    @user.role == 'admin'
  end
end
