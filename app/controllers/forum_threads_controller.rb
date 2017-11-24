class ForumThreadsController < ApplicationController
  before_action :set_forum_thread, except: [:index, :new, :create]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @q = ForumThread.search(params[:q])

    @forum_threads = ForumThread.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ?", @market.id)
    
    if params[:q].present?
      @forum_threads = @q.result.paginate(page: params[:page], per_page: $pagination_count).where("market_id = ?", @market.id)
    end
  end

  def show
    @forum_post = ForumPost.new
  end

  def new
    if current_user.is_advertiser == true
      redirect_to root_path
      flash[:alert] = "Sorry, advertisers do not have permissions to post."
    else
      @forum_thread = ForumThread.new
      @forum_thread.forum_posts.new
    end
  end

  def create
    @forum_thread = current_user.forum_threads.build(forum_thread_params)
    @forum_thread.market_id = @market.id
    @forum_thread.forum_posts.first.user_id = current_user.id

    if @forum_thread.save
      redirect_to @forum_thread
    else
      render action: :new
    end
  end

  private

    def set_banner
      @banner = Banner.first_or_create
    end

    def set_forum_thread
      @forum_thread = ForumThread.find_by!(id: params[:id], market: @market)
    rescue
      flash[:alert] = "Thread could not be found"
      redirect_to root_path
    end

    def forum_thread_params
      params.require(:forum_thread).permit(:subject, :forum_category_id, :market_id, :forum_posts_attributes => [:body, :images])
    end
end
