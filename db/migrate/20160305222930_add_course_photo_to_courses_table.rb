class AddCoursePhotoToCoursesTable < ActiveRecord::Migration
  def up
    add_attachment :courses, :course_photo
  end

  def down
    remove_attachment :courses, :course_photo
  end
end
