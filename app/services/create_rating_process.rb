class CreateRatingProcess
  attr_reader :request_model

  def initialize(request_model)
    @request_model = request_model
  end

  def call
    CreateRatingWorker.perform_async(request_model.post_id, request_model.rating_value)

    average_rating
  end

  def average_rating
    Rating.where(post_id: request_model.post_id).average(:value).to_f
  end
end
