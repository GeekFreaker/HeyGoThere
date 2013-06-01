/* 
 * This scripts defines functions needed to manipulate the map
 * Add and display Markers
 * 
 */

var center_africa = new google.maps.LatLng(1.757537, 18.281250);
var lesotho = new google.maps.LatLng(-29.5495, 28.1851);
var map = null;
var currentPopup;

var markers = [];

var locations = [];
var iterator = 0;

var map;

function initialize() {
  var mapOptions = {
    zoom: 9,
    center: lesotho,
    mapTypeId: google.maps.MapTypeId.HYBRID
  };
  
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
}

google.maps.event.addDomListener(window, 'load', initialize);