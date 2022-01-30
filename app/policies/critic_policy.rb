class CriticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(approved: true).or(scope.where(user_id: @user.id))
      end
    end
  end

  def destroy?
    @user.admin? || (@record.user == @user)
  end
end
