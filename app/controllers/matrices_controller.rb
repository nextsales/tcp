class MatricesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /matrices
  # GET /matrices.json
  def index
    @matrices = Matrix.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matrices }
    end
  end

  # GET /matrices/1
  # GET /matrices/1.json
  def show
    @feeds = @matrix.feeds
    @companies = @matrix.companies
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matrix }
    end
  end

  # GET /matrices/new
  # GET /matrices/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matrix }
    end
  end

  # GET /matrices/1/edit
  def edit
  end

  # POST /matrices
  # POST /matrices.json
  def create
    @matrix.user = current_user
    respond_to do |format|
      if @matrix.save
        format.html { redirect_to @matrix, notice: 'Matrix was successfully created.' }
        format.json { render json: @matrix, status: :created, location: @matrix }
      else
        format.html { render action: "new" }
        format.json { render json: @matrix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matrices/1
  # PUT /matrices/1.json
  def update
    respond_to do |format|
      if @matrix.update_attributes(params[:matrix])
        format.html { redirect_to @matrix, notice: 'Matrix was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @matrix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matrices/1
  # DELETE /matrices/1.json
  def destroy
    @matrix.destroy
    respond_to do |format|
      format.html { redirect_to matrices_url }
      format.json { head :no_content }
    end
  end
end
