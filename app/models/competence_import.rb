class CompetenceImport
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
    if imported_competences.map(&:valid?).all?
      imported_competences.each(&:save!)
      true
    else
      imported_competences.each_with_index do |competence, index|
        competence.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end
  def imported_competences
    @imported_competences ||= load_imported_competences
  end
  
  def load_imported_competences
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      competence = Competence.find_by_id(row["id"]) || Competence.new
      competence.attributes = row.to_hash.slice(*Competence.accessible_attributes)
      competence      
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