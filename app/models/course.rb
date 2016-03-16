class Course < ActiveRecord::Base
  # Database relationships
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  # Validations
  validates :title, presence: true, length: {minimum: 10, maximum: 160}
  validates :description, presence: true, length: {minimum: 20, maximum: 3000}
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}

  # Paperclip
  has_attached_file :course_photo, styles: { banner: "800x350#", thumb: "150x150#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :course_photo, content_type: /\Aimage\/.*\Z/

  def free?
    cost.zero?
  end

  def premium?
    ! free?
  end
end
