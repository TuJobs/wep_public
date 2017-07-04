class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed
        .select(:id, :content, :picture, :user_id, :created_at).post_sort
        .paginate page: params[:page], per_page: Settings.post.size_limit
    end
  end

  def help
  end
end
