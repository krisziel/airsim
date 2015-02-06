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
//= require_tree .
//= require semantic-ui

$(document).ready(function(){
  sizeMap();
  checkAirline();
});
$(window).resize(function(){
  sizeMap();
});

function launchApp() {
  loadMap();
  loadAircraft();
  createRouteList();
  createAircraftList();
  activateNav();
  $('#control').css({display:'block'});
}

function comma(number) {
  number = number || 0;
  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function turn() {
  $.getJSON('demand/turn').done(function(){
    createRouteList();
    createAircraftList();
  });
}
