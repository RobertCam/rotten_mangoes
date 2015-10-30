class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  scope :favourite, lambda { rated_above(6).order(rating_out_of_ten: :desc) }
  scope :rated_above, lambda { |rating| where("reviews.rating_out_of_ten > ?", rating)

  validates :user,
    presence: true

  validates :movie,
    presence: true

  validates :text,
    presence: true

  validates :rating_out_of_ten,
    numericality: { only_integer: true }
  validates :rating_out_of_ten,
    numericality: { greater_than_or_equal_to: 0 }
  validates :rating_out_of_ten,
    numericality: { less_than_or_equal_to: 10 }
end
