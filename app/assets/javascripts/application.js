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
//= require jquery.ui.core
//= require jquery.ui.position
//= require jquery.ui.widget
//= require jquery.ui.menu
//= require jquery.ui.autocomplete
//= require jquery.ui.datepicker
//= require underscore-1.4.3
//= require backbone-0.9.10
//= require date
//= require jquery.dp_calendar.min
//= require visualsearch

//= require_tree . 


String.prototype.format = String.prototype.f = function () {
    var s = this,
        i = arguments.length;

    while (i--) {
        s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
    }
    return s;
};

String.prototype.replaceAll = function (find, replace) {
    return this.replace(new RegExp(find, 'g'), replace);
};

$(document).ready(function () {
    var visualSearch = VS.init({
        container: $('.visual_search'),
        query: '',
        callbacks: {
            search: function (query, searchCollection) {

                json = {};
                if (query.trim() != "") {
                    queries = query.split('" ');

                    for (i = 0; i < queries.length; i = i + 1) {
                        paramText = queries[i].replaceAll('"', '');

                        params = paramText.split(": ");

                        j = $.parseJSON('{ "{0}":"{1}" }'.f(params[0], params[1]));
                        $.extend(json, j);
                    }
                }

                $.get("/smart_reservations/search", json, function (result) {
                    $('#result').html(result);
                });

            },
            facetMatches: function (callback) {

                query = visualSearch.searchBox.currentQuery;

                json = {};
                if (query.trim() != "") {
                    queries = query.split('" ');

                    for (i = 0; i < queries.length; i = i + 1) {
                        paramText = queries[i].replaceAll('"', '');

                        params = paramText.split(": ");

                        j = $.parseJSON('{ "{0}":"{1}" }'.f(params[0], params[1]));
                        $.extend(json, j);
                    }
                }

                $.getJSON("/smart_reservations/facets.json", json, function (data) {
                    callback(data)
                });
            },
            valueMatches: function (facet, searchTerm, callback) {
                $.getJSON("/smart_reservations/values/" + facet + ".json", function (data) {
                    callback(data)
                });

            }
        }
    });
});


$(document).ready(ready)
$(document).on('page:load', ready)


