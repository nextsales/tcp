$(document).ready( function () {
    $('.datatables').dataTable();
		
		$('#competeneces_datatable').dataTable({
			bServerSide: true,
		  sAjaxSource: $('#competeneces_datatable').data('source'),
			sDom: "<'row-fluid table-top-control'<'span6 hidden-phone per-page-selector'l><'span6'f>r>t<'row-fluid table-bottom-control'<'span6'i><'span6'p>>"
		});
		
		$('#companies_datatable').dataTable({
			bServerSide: true,
		  sAjaxSource: $('#companies_datatable').data('source'),
			sDom: "<'row-fluid table-top-control'<'span6 hidden-phone per-page-selector'l><'span6'f>r>t<'row-fluid table-bottom-control'<'span6'i><'span6'p>>"
		});
		
		$.extend( $.fn.dataTableExt.oStdClasses, {
		    "sWrapper": "dataTables_wrapper form-inline"
		});
} );

/*
$('#competeneces_datatable').dataTable
  bServerSide: true
  sAjaxSource: $('#competeneces_datatable').data('source')

$.extend $.fn.dataTableExt.oStdClasses, {
	sWrapper: "dataTables_wrapper form-inline"
}


*/