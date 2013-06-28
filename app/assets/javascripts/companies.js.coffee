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
	