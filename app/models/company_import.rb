class CompanyImport 
  # attr_accessible :title, :body
  
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  

  attr_accessor :file, :current_user

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end
  
  def save
    if imported_companies.map(&:valid?).all?
      imported_companies.each(&:save!)
      #set the user of the imported company as the current user
      imported_companies.each do |company|
        company.user=current_user
      end
      
      true
    else
      imported_companies.each_with_index do |company, index|
        company.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end
  
  def imported_companies
    @imported_companies ||= load_imported_companies
  end

  def load_imported_companies
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      company = Company.find_by_id(row["id"]) || Company.new
      company.attributes = row.to_hash.slice(*Company.accessible_attributes)
      company      
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
