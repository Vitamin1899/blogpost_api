class CreatePostProcess
  attr_reader :request_model

  def initialize(request_model)
    @request_model = request_model
  end

  def call
    @user = User.find_or_create_by(login: request_model.user_login)
    @user.posts.create!(title: request_model.post_title, content: request_model.post_content)
  end
end
