# Reset create competence modal when close event is triggered
jQuery ->
  $('#competeneces_datatable').dataTable
    bServerSide: true
    sAjaxSource: $('#competeneces_datatable').data('source')
	
	$.extend $.fn.dataTableExt.oStdClasses, {
		sWrapper: "dataTables_wrapper form-inline"
	}
	
	$("#create_competence_modal").on "hidden", ->
		$(this).find("input[type=text], textarea").val ""
