class Course < ActiveRecord::Base
  # Database relationships
  belongs_to :user
  has_many :sections

  # Validations
  validates :title, presence: true, length: {minimum: 10, maximum: 160}
  validates :description, presence: true, length: {minimum: 20, maximum: 3000}
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}

  # Paperclip
  has_attached_file :course_photo, styles: { banner: "800x350#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :course_photo, content_type: /\Aimage\/.*\Z/
end
