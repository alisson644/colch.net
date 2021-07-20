class Room < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :title, :location
  validates_length_of :description, :minimum => 30, :allow_blank => false

  def complete_name
    "#{title}, #{location}"
    end
end
