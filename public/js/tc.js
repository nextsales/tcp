jQuery(document).ready(function($){
	if ($("#tc_alert").html() !="") {
		$.gritter.add({
			// (string | mandatory) the heading of the notification
			title: 'Alert',
			// (string | mandatory) the text inside the notification
			text: $("#tc_alert").html()
		});
	}
	
	if ($("#tc_notice").html() !="") {
		$.gritter.add({
			// (string | mandatory) the heading of the notification
			title: 'Notice',
			// (string | mandatory) the text inside the notification
			text: $("#tc_notice").html()
		});
	}
	
});