// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require bootstrap
//= require bootstrap-datetimepicker
//= require turbolinks
//= require migration
//= require jquery.ui.core.js
//= require jquery.ui.position.js
//= require jquery.ui.datepicker.js
//= require date.js
//= require jquery.dp_calendar.min.js
//= require_tree .

String.prototype.format = String.prototype.f = function() {
    var s = this,
        i = arguments.length;

    while (i--) {
        s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
    }
    return s;
};

$(document).ready(function() {
    var visualSearch = VS.init({
      container : $('.visual_search'),
      query     : '',
      callbacks : {
        search       : function(query, searchCollection) {
        	var room;
        	var when;
          $(searchCollection).each(function (i, item){
          	if (item.models[0].attributes.category == 'room'){
          		room = item.models[0].attributes.value;
          	}else if (item.models[0].attributes.category == 'when'){
          		when = item.models[0].attributes.value;
          	}
          });

          if (room && when){
          	url = "/smart_reservations/search/{0}/{1}.json".f(room,when);
          } else if (room){
						url = "/smart_reservations/search/{0}.json".f(room);
          }
          
          $.getJSON( url, function( data ) {
            callback(data)
          });
        },
        facetMatches : function(callback) {
          $.getJSON( "/smart_reservations/facets.json", function( data ) {
            callback(data)
          });
        },
        valueMatches : function(facet, searchTerm, callback) {
            $.getJSON( "/smart_reservations/values/"+ facet +".json", function( data ) {
              callback(data)
            });
            
          }
        }
      });
  });
