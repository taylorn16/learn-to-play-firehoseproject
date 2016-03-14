class Lesson < ActiveRecord::Base

  include RankedModel

  belongs_to :section
  ranks :row_order, :with_same => :section_id

  # Paperclip
  has_attached_file :video, styles: {standard: {geometry: '640x480!', format: 'mp4'}}, processors: [:transcoder]
  validates_attachment_content_type :video, content_type: ['application/x-shockwave-flash', 'application/x-shockwave-flash', 'application/flv', 'video/x-flv', 'video/mp4']

end
