// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

// jquery and friends
//= require jquery
//= require jquery_ujs

// jquery plugins
//= require lib/icheck.js/jquery.icheck
//= require lib/sparkline/jquery.sparkline
//= require lib/jquery-ui-1.10.1.custom
//= require lib/jquery.slimscroll

// d3, nvd3-->
//= require lib/nvd3/lib/d3.v2
//= require lib/nvd3/nv.d3.custom

// nvd3 models
//= require lib/nvd3/src/models/scatter
//= require lib/nvd3/src/models/axis
//= require lib/nvd3/src/models/legend
//= require lib/nvd3/src/models/multiBar
//= require lib/nvd3/src/models/multiBarChart
//= require lib/nvd3/src/models/line
//= require lib/nvd3/src/models/lineChart
//= require lib/nvd3/stream_layers

// backbone and friends
//= require lib/backbone/underscore-min
//= require lib/backbone/backbone-min
//= require lib/backbone/backbone.localStorage-min

// bootstrap default plugins
//= require js/bootstrap/bootstrap-transition
//= require js/bootstrap/bootstrap-collapse
//= require js/bootstrap/bootstrap-alert
//= require js/bootstrap/bootstrap-tooltip
//= require js/bootstrap/bootstrap-popover
//= require js/bootstrap/bootstrap-button
//= require js/bootstrap/bootstrap-tab
//= require js/bootstrap/bootstrap-dropdown

// basic application js
//= require js/app
//= require js/settings

// page specific
//= require js/index
//= require js/chat

//= require_tree .

//= require jquery.tokeninput
//= require_directory .
//= require jquery.inview.min

$(document).ready(function() {
  $('a.hook').bind('inview', function(e,visible) {
    if( visible ) {
      $.getScript($(this).attr("href"));
    }
  });
});
