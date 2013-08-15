# 
# $('#myTab a:first').tab('show');
# $('#myTab a').click(function (e) {
#   e.preventDefault();
#   $(this).tab('show');
# });

jQuery ->
	$('#myTab a:first').tab('show')
	$('#myTab a').click (e) -> 
		e.preventDefault()
		$(this).tab('show')
		
	$(document).on "click", ".open-CreateCompanyDialog", ->
		$("#company_name").val $(this).data("cname")
		$("#company_linkedin_id").val $(this).data("lid")
		$("#company_logo_url").val $(this).data("logo_url")
		$("#company_add_matrix").val $(this).data("matrix_id")
		$("#create_company_modal_label").html $(this).data("cname")
		
	