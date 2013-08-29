
/*$(".Import_all" ).on( "click", function() {
	alert("clicked"); 
    $.ajax({
            type: "POST",
            url: save_imported_company_imports_path,
            data: {companies: "test"},
            success: function() { alert("Success!"); }
    });
  });
  */

/*

Loi khi compile -> 

$(document).ready(function() {
	$('#company_import_all').click(function(){
	    $.ajax({
	            type: "POST",
	            url: "/company_imports/save_imported",
	            dataType: "json",
	            data: {companies: @imported_companies.to_s},
	            success: function() { alert("Success!"); }
	    });
		
	});
});
*/

$(document).ready(function() {
	$(".company_imports.create a.imported_company").each(function( index ) {
		$(this).click(function(){
			console.log( index + ": " + $(this).data("name") );
			$.ajax({
	            type: "POST",
	            url: "/companies",
	            dataType: "json",
	            data: {company: {name: $(this).data("name"), description:$(this).data("description"), linkedin_id: $(this).data("linkedinid")}},
	            success: function() { alert("Success!"); }
	    });
		});
	  //console.log( index + ": " + $(this).text() );
	});

});