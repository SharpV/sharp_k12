class GroupTopic < ActiveRecord::Base

  belongs_to :group
  belongs_to :user
  belongs_to :category

end
