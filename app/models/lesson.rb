class Lesson < ActiveRecord::Base

  belongs_to :section

  # Paperclip
  has_attached_file :video, styles: {standard: {geometry: '640x480!', format: 'mp4'}}, processors: [:transcoder]
  validates_attachment_content_type :video, content_type: ['application/x-shockwave-flash', 'application/x-shockwave-flash', 'application/flv', 'video/x-flv', 'video/mp4']

end
