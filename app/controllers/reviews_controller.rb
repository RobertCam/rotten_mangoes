class ReviewsController < ApplicationController
  
  before_filter :load_movie
  before_filter :restrict_access

  def index
      @reviews = current_user.reviews.favourite
    else
      render :show
  end

  def new
    @review = @movie.reviews.build
  end

  def create
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @movie, notice: "Review added"
    else
      render :new
    end
  end

  protected 

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end
end
