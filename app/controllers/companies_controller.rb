class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    @suggested_companies = current_user.suggested_companies.where(is_enable: true).order("rank DESC")
    @matrices = current_user.matrices
    
    #@linkedin_following_companies = current_user.test_following_companies
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end
  
  def search
    @company = Company.new
    keyword = params[:keyword]
    if (!keyword.blank?)
      @linkedin_companies = current_user.linkedin_client.search({:keywords => keyword}, "company").companies.all
    end
    
    respond_to do |format|
      format.html
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @feeds = @company.feeds
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company.name = params[:name]
    @companies = []
    @linkedin_companies = []
    
    if (!@company.name.blank?)
      @companies = Company.find_all_by_name(params[:name])
      @linkedin_companies = current_user.linkedin_client.search({:keywords => params[:name]}, "company").companies.all
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company.user = current_user
    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: @company.name + ' was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: @company.name + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
