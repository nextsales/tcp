class IndustryImportsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @industry_import = IndustryImport.new
  end

  def create
    @industry_import = IndustryImport.new(params[:industry_import])
    @industry_import.current_user=current_user
    if @industry_import.save
      redirect_to root_url, notice: "Imported industries successfully."
    else
      render :new
    end
    
  end
end
