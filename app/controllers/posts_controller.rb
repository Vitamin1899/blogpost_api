class PostsController < ApplicationController
  def create
    request_model = PostRequestModel.new(post_params)
    if request_model.valid?
      @post = CreatePostProcess.new(request_model).call
      json_response(@post, :created)
    else
      json_response({ message: request_model.errors }, :unprocessable_entity)
    end
  end

  def index
    @ip_list = Post.joins(:ratings)
                   .select('posts.id, title, content, avg(ratings.value) as rating')
                   .group('id')
                   .order('rating desc')
                   .limit(post_params[:top_n] || 10)
    json_response(@ip_list)
  end

  def user_ips
    # Post.joins(:user)
    #     .group('users.login')
    #     .group('posts.author_ip')
    #     .order('users.login, posts.author_ip')
    #     .pluck('users.login', 'posts.author_ip')
    Post.includes(:user)
        .group_by(&:author_ip)
        .each_with_object({}) do |(ip, posts), res|
          res[ip] = posts.map(&:login) if posts.count > 1
        end
  end

  private

  def post_params
    params.permit(
      :top_n,
      user: :login,
      post: %i[title content author_ip]
    )
  end
end
