class PostRequestModel
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  validates :post_title, :post_content, presence: true

  def post_title
    post_params['title']
  end

  def post_content
    post_params['content']
  end

  def post_author_ip
    user_params['author_ip']
  end

  def user_login
    user_params['login']
  end

  private

  attr_reader :params

  def user_params
    params['user'] || {}
  end

  def post_params
    params['post'] || {}
  end
end
