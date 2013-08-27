class CompetencesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Competence.count,
      iTotalDisplayRecords: competences.total_entries,
      aaData: data
    }
  end

private

  def data
    competences.map do |competence|
      [
        competence.id,
        competence.name,
        competence.description,
      ]
    end
  end

  def competences
    @competences ||= fetch_competences
  end

  def fetch_competences
    competences = Competence.order("#{sort_column} #{sort_direction}")
    competences = competences.page(page).per_page(per_page)
    if params[:sSearch].present?
      competences = competences.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    competences
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id name description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
