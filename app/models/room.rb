class Room < ApplicationRecord
  extend FriendlyId

  has_many :reviews, :dependent => :destroy
  has_many :reviewed_rooms, :through => :reviews, :source => :room
  belongs_to :user
  
  validates_presence_of :title, :location
  validates_presence_of :slug
  validates_length_of :description, :minimum => 30, :allow_blank => false
  mount_uploader :picture, PictureUploader
  
  friendly_id :title, :use => [:slugged, :history]

  scope :most_recent, -> {order('created_at DESC')}


  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      where('location LIKE :query OR
             title LIKE :query OR
             description LIKE :query', :query => "%#{query}%")
    else
      most_recent
    end
  end
end
