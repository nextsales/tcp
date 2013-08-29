jQuery ->
	$("#company_competence_tokens").tokenInput '/competences.json', 
		theme: "facebook"
		prePopulate: $("#company_competence_tokens").data('load')
	
	$("#company_industry_tokens").tokenInput '/industries.json',
		theme: "facebook"
		prePopulate: $("#company_industry_tokens").data('load')
		
	$("#company_matrix_tokens").tokenInput '/matrices.json',
			theme: "facebook"
			prePopulate: $("#company_matrix_tokens").data('load')