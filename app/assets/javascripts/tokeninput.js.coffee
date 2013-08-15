jQuery ->
	$("#company_competence_tokens").tokenInput '/competences.json', 
		theme: "facebook"
		prePopulate: $("#company_competence_tokens").data('load')