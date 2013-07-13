// Reset create competence modal when close event is triggered
$('#create_competence_modal').on('hidden', function () {
		$(this).find("input[type=text], textarea").val("");
})