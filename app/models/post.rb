class Post < ActiveRecord::Base

  scope :share, where("grade_id is not null")

  acts_as_commentable
  acts_as_taggable

  default_scope where("postable_id is not null and slug is not null and postable_type is not null")

  validates :title, :slug, :presence => true

  validates :body, :length => { :minimum => 5 }

  before_validation :generate_slug

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  belongs_to :postable, :polymorphic => true

  belongs_to :category, foreign_key: :category_id

  belongs_to :grade

  belongs_to :subject
  
  #paginates_per 30
  
  def to_param
    slug ? "#{id}-#{slug.parameterize}" : id.to_s
  end

  def generate_slug
    self.slug = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end

  def belongs? actor
    postable_id == actor.id && postable_type == actor.class.to_s.classify
  end

end
