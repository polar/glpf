class OrgTeam < ActiveRecord::Base

  # name, String

  belongs_to :category

  after_save :ensure_name_consistency

  has_and_belongs_to_many :users

  def member?(user)
    users.include?(user)
  end

  def ensure_name_consistency
    if name != category.name
      category.name = name
      category.save
    end
  end

end
