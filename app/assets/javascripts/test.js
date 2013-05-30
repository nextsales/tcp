$(document).ready(function() {
	$('.masonry_feed').masonry({
		itemSelector: '.box',
		isAnimated: true,
	  columnWidth: function( containerWidth ) {
	    return containerWidth / 5;
	  }
	});
});

