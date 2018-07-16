class RatingsController < ApplicationController
  def create
    request_model = RatingRequestModel.new(rating_params)
    if request_model.valid?
      average_rating = CreateRatingProcess.new(request_model).call
      json_response(average_rating, :created)
    else
      json_response({ message: request_model.errors }, :unprocessable_entity)
    end
  end

  private

  def rating_params
    params.permit(:post_id, :value)
  end
end
