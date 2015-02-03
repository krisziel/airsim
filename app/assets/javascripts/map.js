var globalMap;

function sizeMap() {
  $('#map').css({width:$(window).width()-300});
}
function loadMap(){
  L.mapbox.accessToken = 'pk.eyJ1Ijoia3ppZWwiLCJhIjoiaVROWDVNcyJ9.hxCBMTpnmZjG8X_03FYMBg';
  var map = L.mapbox.map('map', 'kziel.l04pnpnd', {
    attributionControl: false,
    infoControl: true,
    minZoom:3,
    maxZoom:10
  })
  .setView([13.6296633,77.5570161],4);
  // .setView([37.618,-122.375], 6);
  // map.setMaxBounds([[-90,-180], [90,180]]);
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
