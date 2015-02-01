var globalMap;

function sizeMap() {
  $('#map').css({width:$(window).width()-300});
}
function loadMap(){
  L.mapbox.accessToken = 'pk.eyJ1Ijoia3ppZWwiLCJhIjoiaVROWDVNcyJ9.hxCBMTpnmZjG8X_03FYMBg';
  var map = L.mapbox.map('map', 'kziel.l04pnpnd', {
    attributionControl: false,
    infoControl: true
  })
  .setView([13.6296633,77.5570161],4);
  // .setView([37.618,-122.375], 6);
  map.setMaxBounds([[-90,-180], [90,180]]);
  globalMap = map;
  addAirports(map);
}
