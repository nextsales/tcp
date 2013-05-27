class FeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @feeds = Feed.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end 
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feed }
    end
  end
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end
  
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed.matrices.build
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'feed was successfully created.' }
        format.json { render json: @feed, status: :created, location: @feed }
      else
        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

end
