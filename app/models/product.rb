class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category

  serialize :recommended_items, JSON
  serialize :coordinating_items, JSON
  serialize :related_items, JSON

  def catelog
    category.parent.parent.name + "/" +  category.parent.name + "/" + category.name
  end
end
