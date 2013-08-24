class CompanyImportsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @company_import = CompanyImport.new
  end
   
  def save_imported
    raise params[:companies].to_yaml
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  
  def create
    #puts params[:company_import]
    @company_import = CompanyImport.new(params[:company_import])
    @company_import.current_user=current_user
    # if @company_import.save
      # redirect_to root_url, notice: "Imported companies successfully."
    # else
      # render :new
    # end
#     
    case File.extname(@company_import.file.original_filename)
      when ".csv" then spreadsheet = Roo::Csv.new(@company_import.file.path, nil, :ignore)
      when ".xls" then spreadsheet = Roo::Excel.new(@company_import.file.path, nil, :ignore)
      when ".xlsx" then spreadsheet = Roo::Excelx.new(@company_import.file.path, nil, :ignore)
      else raise "Unknown file type: #{@company_import.file.original_filename}"
    end
    
    @imported_companies =Array.new
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      if row["linkedin_id"]
        if row["linkedin_id"].is_a?Numeric 
          row["linkedin_id"] = row["linkedin_id"].to_i 
        end
      end
      company = Company.find_by_id(row["id"]) || Company.new
      company.attributes = row.to_hash.slice(*Company.accessible_attributes)
      @imported_companies << company      
    end
    
    render "preview.html.erb"
  end
end
