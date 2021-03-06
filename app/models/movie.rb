class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :poster, PosterUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  def review_average
    if reviews.size == 0
      "This movie has no ratings"
    else
      "#{reviews.sum(:rating_out_of_ten)/reviews.size}/10"    
    end
  end

  def self.search(query)
    where("title LIKE '%#{query}%' OR director LIKE '%#{query}%'")
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "You cannot review a movie that hasn't been released yet.") if release_date > Date.today
    end
  end

end
