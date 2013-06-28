$(document).ready(function(){
	// Menu active
	$('ul#side-nav li a').each(function(){
		if (String(window.location).indexOf($($(this))[0].href) >= 0)
			$(this).parent().addClass('active');
	});
	
	$("#feed").slimscroll({
      height: 'auto',
      size: '5px',
      alwaysVisible: true,
      railVisible: true
  });

  $("#chat-messages").slimscroll({
      height: '240px',
      size: '5px',
      alwaysVisible: true,
      railVisible: true
  });
});


