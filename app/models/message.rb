class Message < ActiveRecord::Base
  attr_accessible :send_to_parent, :recipient_id, :title, :body

  default_scope  { order('created_at DESC') }


  scope :webclass, where('webclass_id is not null and recipient_id is not null and sender_id is not null')

  validates :title, :body, :recipient_id, :presence => true

  belongs_to :webclass
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  belongs_to :parent, :class_name => "Message"
  has_many :replies, :foreign_key => "parent_id", :class_name => "Message"

end
