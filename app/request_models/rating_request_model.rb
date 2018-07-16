class RatingRequestModel
  include ActiveModel::Validations

  attr_reader :params

  def initialize(params)
    @params = params
  end

  validates :post_id, presence: true
  validates :rating_value, inclusion: { in: 1..5 }, presence: true

  def post_id
    params['post_id']
  end

  def rating_value
    params['value'].to_f
  end
end
