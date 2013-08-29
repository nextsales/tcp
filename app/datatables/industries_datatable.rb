class IndustriesDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Industry.count,
      iTotalDisplayRecords: industries.total_entries,
      aaData: data
    }
  end

private

  def data
    industries.map do |industry|
      [
        industry.id,
        link_to(industry.name, industry),
        industry.description,
        '<a href="/industries/'+industry.id.to_s+'/edit" class="btn btn-small btn-info"><i class="icon-edit"></i> Edit</a>',
      ]
    end
  end

  def industries
    @industries ||= fetch_industries
  end

  def fetch_industries
    industries = Industry.order("#{sort_column} #{sort_direction}")
    industries = industries.page(page).per_page(per_page)
    if params[:sSearch].present?
      industries = industries.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    industries
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
