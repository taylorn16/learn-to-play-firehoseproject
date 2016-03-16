class Lesson < ActiveRecord::Base

  include RankedModel

  belongs_to :section
  ranks :row_order, :with_same => :section_id

  # Paperclip
  has_attached_file :video, styles: {standard: {geometry: '640x480!', format: 'mp4'}}, processors: [:transcoder]
  validates_attachment_content_type :video, content_type: ['application/x-shockwave-flash', 'application/x-shockwave-flash', 'application/flv', 'video/x-flv', 'video/mp4']

  def prev_lesson
    lesson = self.section.lessons.where('row_order < ?', self.row_order).rank(:row_order).last
    if ! lesson && section.prev_section
      return section.prev_section.lessons.rank(:row_order).last
    end

    lesson
  end

  def next_lesson
    lesson = self.section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first
    if ! lesson && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end

    lesson
  end

end
