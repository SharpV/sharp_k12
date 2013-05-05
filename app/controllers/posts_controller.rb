class PostsController < ApplicationController

  set_tab :posts, :site_nav

  
  def index
    if params[:grade_id]
      @posts = Post.share.includes(:creator).where(grade_id: params[:grade_id]).page params[:page]
    elsif params[:subject_id]
      @posts = Post.share.includes(:creator).where(subject_id: params[:subject_id]).page params[:page]
    else
      @posts = Post.share.includes(:creator).order('comments_count').page params[:page]
    end
    @top_users = Post.top_users

    set_tab :index, :posts_nav
  end
  
  def new
    @post = Post.new
  end

  def latest
    @posts = Post.share.includes(:creator).order('created_at desc').page params[:page]
    @top_users = Post.top_users

    set_tab :latest, :posts_nav
    render template: 'posts/index'
  end
  
  def show
    @post = Post.find params[:id]
  end
  
  def hot
    @posts = Post.share.includes(:creator).order('readings_count desc').page params[:page]
    @top_users = Post.top_users

    set_tab :hot, :posts_nav
    render template: 'posts/index'
  end

  def top
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to group_post_path(@current_group, @post) 
    else
      render :action => :edit
    end
  end

end
