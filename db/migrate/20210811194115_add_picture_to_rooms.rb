class AddPictureToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :picture, :string
  end
end
