class EmployeesPolicy < ApplicationPolicy
  def index?
    trusted? || admin? || owner?
  end

  def create?
    trusted? || admin? || owner?
  end

  def update?
    trusted? || admin? || owner?
  end

  def destroy?
    trusted? || admin? || owner?
  end
end