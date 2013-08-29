class CompetenceImportsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @competence_import = CompetenceImport.new
  end

  def create
    @competence_import = CompetenceImport.new(params[:competence_import])
    @competence_import.current_user=current_user
    if @competence_import.save
      redirect_to competences_url, notice: "Competences successfully."
    else
      render :new
    end
    
  end
end
