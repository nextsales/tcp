
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
