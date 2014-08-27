class Cat < ActiveRecord::Base
  COLORS = ["red", "orange", "black", "white", "pink"]
  SEX = ["M", "F"]

  validates :age, :birth_date, :color, :name, :sex, presence: true
  validates :age, numericality: true
  validates :color, inclusion: { in: COLORS, message: "Color is not a valid color" }
  validates :sex, inclusion: { in: SEX, message: "Not a valid gender" }
            
  
  has_many :cat_rental_requests, dependent: :destroy
end
