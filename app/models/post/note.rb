require 'pathname'
require 'carrierwave/orm/activerecord'

class Post::Note < Post
  mount_uploader :file, FileUploader 
  
  acts_as_taggable_on :tags
  acts_as_commentable
  
  after_save :update_tag_list

  belongs_to :user

  before_validation :generate_slug
  #after_save :conv_to_swf
  
  validates :title, :presence => true, :length => {:within => 1..100}
  validates :body, :presence => true
  validates :user_id, :presence => true
  
  
  #attr_accessor :minor_edit, :title, :body, :slug, :domain_id
  
  TYPES = {:article => 'article', :link => 'link', :pic => 'pic', :doc => 'doc', :question => 'question', 
    :audio => 'audio', :video => 'video'}
  
  scope :by_type, lambda { |type| where("kind = ?", type) }
  
  def avatar
    case kind
    when TYPES[:article] then "icon-edit"
    when TYPES[:pic] then "icon-picture"
    when TYPES[:link] then "icon-link"
    when TYPES[:doc] then "icon-file"
    when TYPES[:audio] then "icon-volume-up"
    when TYPES[:video] then "icon-camera"
    else "icon-flag"
    end
  end
  
  

  def type
    self.kind || "article"
  end

  def to_param
    "#{id}-#{url.parameterize}"
  end

  def login
    user.login
  end

  def update_tag_list
    if !self.tag_list.empty? and domain
      domain.set_tag_list_on(:post_tag, self.tag_list.join(","))
      domain.save
      user.update_attribute :tag_list, self.tag_list.join(",")
    end
    
  end

  def denormalize_comments_count!
    Post.update_all(["approved_comments_count = ?", self.approved_comments.count], ["id = ?", self.id])
  end

  def generate_slug
    self.url = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end

  class << self
    def build_for_preview(params)
      post = Post.new(params)
      post.generate_slug
      post.set_dates
      post.apply_filter
      TagList.from(params[:tag_list]).each do |tag|
        post.tags << Tag.new(:name => tag)
      end
      post
    end
  end

end
