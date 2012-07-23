class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
	  if user_signed_in?
		  if params[:group].nil?
			  @posts = PostsHelper.get_all_posts current_user.company_id
		  else
			  @group = Group.find(params[:group])
			  @posts = Post.where('company_id = ? AND group_id = ?', current_user.company_id, params[:group]).order('created_at DESC')
			end

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @posts }
	    end
	  else
		  redirect_to root_path
		end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
	  if user_signed_in?
	    @post = Post.find(params[:id])

	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @post }
	    end
	  else
		  redirect_to root_path
		end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end