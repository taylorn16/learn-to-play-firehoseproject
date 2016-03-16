class Section < ActiveRecord::Base

  include RankedModel

  belongs_to :course
  has_many :lessons, dependent: :destroy
  ranks :row_order, :with_same => :course_id

  def prev_section
    self.course.sections.where('row_order < ?', self.row_order).rank(:row_order).last
  end

  def next_section
    self.course.sections.where('row_order > ?', self.row_order).rank(:row_order).first
  end

end
