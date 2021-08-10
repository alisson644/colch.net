class Room < ApplicationRecord
  has_many :reviews, :dependent => :destroy
  has_many :reviewed_rooms, :through => :reviews, :source => :room
  belongs_to :user
  
  validates_presence_of :title, :location
  validates_length_of :description, :minimum => 30, :allow_blank => false

  scope :most_recent, -> {order('created_at DESC')}


  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query[0].present?
      where('location LIKE :query OR
             title LIKE :query OR
             description LIKE :query', :query => "%#{query[0]}%")
    else
      most_recent
    end
  end
end
