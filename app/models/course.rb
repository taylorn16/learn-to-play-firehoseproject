class Course < ActiveRecord::Base

  # Database relationships
  belongs_to :user

  # Validations
  validates :title, presence: true, length: {minimum: 10, maximum: 160}
  validates :description, presence: true, length: {minimum: 20, maximum: 3000}
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}

end
