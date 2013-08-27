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
    puts params
    @companies = @matrix.companies
    if params[:twitter_last_ids]
      if params[:linkedin_next_start_ids] 
        @feeds, @twitter_last_ids, @linkedin_next_start_ids  = @matrix.crawl_feed(5, params[:twitter_last_ids], params[:linkedin_next_start_ids])
      else
        @feeds, @twitter_last_ids, @linkedin_next_start_ids  = @matrix.crawl_feed(5, params[:twitter_last_ids], nil)
      end
    else
      if params[:linkedin_next_start_ids]
        @feeds, @twitter_last_ids, @linkedin_next_start_ids = @matrix.crawl_feed(5, nil, params[:linkedin_next_start_ids])
      else
        @feeds, @twitter_last_ids, @linkedin_next_start_ids = @matrix.crawl_feed(10, nil,nil)
      end
    end
    respond_to do |format|
      format.xlsx{
        render xlsx: "show", disposition: "attachment", filename: "#{@matrix.name}.xlsx"
      }
      format.html # show.html.erb
      format.json { render json: @matrix }
      format.js
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
    #@matrix.user_matrix_r.new(user_id: current_user.id).save
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
  
  def add
    @company = Company.new
    keyword = params[:keyword]
    if (!keyword.blank?)
      @linkedin_companies = current_user.linkedin_client.search({:keywords => keyword}, "company").companies.all
    end
    
    respond_to do |format|
      format.html
    end
  end
  
  def add_company
    company_id = params[:id]
    @matrix.company_matrix_rs.build(company_id: company_id).save
    
    respond_to do |format|
      format.html{ redirect_to @matrix}
      format.json
    end
  end
  
  def feed
    #raise @matrix.feeds.first.raw_data.to_json
    @feeds = @matrix.feeds.order('created_at DESC')
    respond_to do |format|
      format.html
      format.json { render json: @feeds }
    end
  end
end
