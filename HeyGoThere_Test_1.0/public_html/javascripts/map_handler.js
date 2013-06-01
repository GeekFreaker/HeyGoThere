/* 
 * This scripts defines functions needed to manipulate the map
 * Add and display Markers
 * 
 */

var icon = new google.maps.MarkerImage("./images/map_markers/hospital-building.png",
           new google.maps.Size(32, 32), new google.maps.Point(0, 0),
           new google.maps.Point(16, 32));

var center_africa = new google.maps.LatLng(1.757537, 18.281250);
var map = null;
var currentPopup;

var markers = [];

var locations = [];
var iterator = 0;

function createLocations(lat, lng) {
    //confirm("bonjour : Lat: '" + lat + "', Lon: '"+ lng +" '");
    locations.push(new google.maps.LatLng(lat, lng));
    //window.confirm("bonjour : Lat: '" + lat + "', Lon: '"+ lng +" '");
}

function addMarker() {
    //confirm("Adding Markers");
    markers.push(new google.maps.Marker({
        position: locations[iterator],
        icon: icon,
        draggable: false,
        map: map,
        animation: google.maps.Animation.DROP
    }));
    iterator++;
}

// Sets the map on all markers in the array.
function setAllMap(map) {
    //confirm("Set Markerssss " + markers.length);
    for (var i = 0; i < markers.length; i++) {
      //confirm("Set Markers");
      markers[i].setMap(map);
    }
}  

function dropMarkers() {
  //confirm("Set Markers");
  setAllMap(null);
  setAllMap(map);
  for (var i = 0; i < locations.length; i++) {
      setTimeout(function() {
          addMarker();
      }, i * 10);                            
  }
}

function initMap() {
    //confirm("Initialising . . .");
    var mapOptions = {
        center: center_africa,
        zoom: 4,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    //setAllMap(map);
}

google.maps.event.addDomListener(window, 'load', initMap);