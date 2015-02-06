var globalMap;

function sizeMap() {
  $('#map').css({width:$(window).width()-300});
  $('#control .steps').css({height:$(window).height()-73});
}
function loadMap(){
  L.mapbox.accessToken = 'pk.eyJ1Ijoia3ppZWwiLCJhIjoiaVROWDVNcyJ9.hxCBMTpnmZjG8X_03FYMBg';
  var map = L.mapbox.map('map', 'kziel.l04pnpnd', {
    attributionControl: false,
    infoControl: true,
    minZoom:3,
    maxZoom:14
  }).setView([39.8282,-98.5795], 5);
  map.setMaxBounds([[-90,-180], [90,180]]);
  globalMap = map;
  addAirports(map);
}
function latlon(obj) {
  var ll = {}
  if(obj.x) {
    ll.lat = obj.y;
    ll.lon = obj.x;
  } else {
    ll = obj
  }
  return L.latLng(ll);
}
