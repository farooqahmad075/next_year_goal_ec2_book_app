class ReviewPolicy < ApplicationPolicy

  def eidt?
    update?
  end

  def update?
    record.user == user
  end

end