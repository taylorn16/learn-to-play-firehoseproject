class AddVideoToLessons < ActiveRecord::Migration
  def up
    add_attachment :lessons, :video
  end

  def down
    remove_attachment :lessons, :video
  end
end
