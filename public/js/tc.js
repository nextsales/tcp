// Menu active
$(document).ready(function(){
	$('ul#side-nav li a').each(function(){
		if (String(window.location).indexOf($($(this))[0].href) >= 0)
			$(this).parent().addClass('active');
	});
});
