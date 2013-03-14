class Folder < ActiveRecord::Base
  include TheSortableTree::Scopes

  attr_accessible :name, :parent_id, :user_id

  default_scope where("user_id is not null")

  belongs_to :user
  
  has_many :media
  
  acts_as_nested_set

  include TheSortableTree::Scopes
  
  def title
    name
  end
      
end