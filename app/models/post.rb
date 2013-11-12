class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable , polymorphic: true
  has_many :post_taggings, dependent: :destroy
  has_many :tags, through: :post_taggings


  has_attached_file :photo, #:styles => { :small => "250x350>" },
                  :url  => "/assets/posts/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  #validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']



def self.tagged_with(name)
    Tag.find_by_name(name).posts
  end

  def tags_list
    tags.map(&:name).join(", ")
  end


  def update_tags(update_tags,post)
    param_tags =[]
    update_tags.split(",").uniq.map do |n|
      param_tags << Tag.find_or_create_by(name: n.strip.downcase)
    end
    new_tags = param_tags - tags
    remove_tags = tags - param_tags
    new_tags.each do |tag|
      PostTagging.create(post: post, tag: tag)
    end
    remove_tags.each do |tag|
      remove_record = PostTagging.where(post: post, tag:tag)
      remove_record.each do |o|
        o.destroy
      end
    end
  end




end