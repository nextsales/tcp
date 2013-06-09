class CompanyImportsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @company_import = CompanyImport.new
  end

  def create
    @company_import = CompanyImport.new(params[:company_import])
    @company_import.current_user=current_user
    if @company_import.save
      redirect_to root_url, notice: "Imported products successfully."
    else
      render :new
    end
  end
end
