# Reset create competence modal when close event is triggered
###
$(document).ready ->
	$("#competeneces_datatable").dataTable
		bServerSide: true
		sAjaxSource: $("#competeneces_datatable").data("source")
		bProcessing: true
		sDom: "<'row-fluid table-top-control'<'span6 hidden-phone per-page-selector'l><'span6'f>r>t<'row-fluid table-bottom-control'<'span6'i><'span6'p>>"

	$.extend $.fn.dataTableExt.oStdClasses,
		sWrapper: "dataTables_wrapper form-inline"
		
	$("#create_competence_modal").on "hidden", ->
		$(this).find("input[type=text], textarea").val ""
###

$(document).ready ->
	$("#create_competence_modal").on "hidden", ->
		$(this).find("input[type=text], textarea").val ""