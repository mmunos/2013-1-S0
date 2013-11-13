class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable , polymorphic: true
  #has_many :post_taggings, dependent: :destroy
  #has_many :tags, through: :post_taggings


  has_attached_file :photo, #:styles => { :small => "250x350>" },
                  :url  => "/assets/posts/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  #validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end