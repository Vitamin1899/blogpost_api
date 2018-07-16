class CreateRatingWorker
  include Sidekiq::Worker

  def perform(post_id, value)
    Post.find(post_id).ratings.create!(value: value)
  end
end
