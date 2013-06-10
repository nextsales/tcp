class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
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
    @company.user = current_user
    5.times {@company.assets.build}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    (5 - @company.assets.length).times {@company.assets.build}
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
  
  def csv_template
    @companies = Company.all
    respond_to do |format|
      format.csv { send_data @companies.to_csv_template }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end
  
end
