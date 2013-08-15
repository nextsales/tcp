class IndustryImport
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
    if imported_industries.map(&:valid?).all?
      imported_industries.each(&:save!)
      true
    else
      imported_industries.each_with_index do |industry, index|
        industry.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end
  
  def imported_industries
    @imported_industries ||= load_imported_industries
  end
  
  def load_imported_industries
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      industry = Industry.find_by_id(row["id"]) || Industry.new
      industry.attributes = row.to_hash.slice(*Industry.accessible_attributes)
      industry      
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