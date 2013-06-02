/* 
 * This scripts defines functions needed to manipulate the map
 * Add and display Markers
 * 
 */

var center_africa = new google.maps.LatLng(1.757537, 18.281250);
var lesotho = new google.maps.LatLng(-29.5495, 28.1851);
var maseru = new google.maps.LatLng(-29.308319, 27.4916);
var map = null;
var currentPopup;

var markers = [];

var locations = [];
var iterator = 0;

var map;
var isOpen = false;
var markerPlaced = false;
var markerPos = null;

var kind;
var description;
var icon;
var green_icon = new google.maps.MarkerImage("images/markers/green.png",
                       new google.maps.Size(32, 32), new google.maps.Point(0, 0),
                       new google.maps.Point(16, 32));
var orange_icon = new google.maps.MarkerImage("images/markers/orange.png",
                       new google.maps.Size(32, 32), new google.maps.Point(0, 0),
                       new google.maps.Point(16, 32));

// Place marker at a given location on the map
<<<<<<< HEAD
function placeMarker(position, map, description, kind) {
  
  if (kind === 'warning') {
    icon = orange_icon;
  } else {
    icon = green_icon;
  }
=======
function placeMarker(position, map, description) {
>>>>>>> 669159faf8316b7c23b26919044c0d68edb4f0c3
  
  var marker = new google.maps.Marker({
    position: position,
    icon: icon,
    map: map
  });
  
   var infowindow = new google.maps.InfoWindow({
      content: description
  });
 
  makeInfoWindowEvent(map, infowindow, marker);
  console.log(position);
  map.panTo(position);
}


//function to display the box
function showOverlayBox() {
    
	//if box is not set to open then don't do anything
	if( isOpen === false ) return;
    console.log("Opening overlay . . .");
    document.getElementById("panel").style.display="none";
	// set the properties of the overlay box, the left and top positions
	$('.overlayBox').css({
		display:'block',
		left:( $(window).width() - $('.overlayBox').width() )/2,
		top:( $(window).height() - $('.overlayBox').height() )/2 -20,
		position:'absolute'
	});
	// set the window background for the overlay. i.e the body becomes darker
	$('.bgCover').css({
		display:'block',
		width: $(window).width(),
		height:$(window).height()
	});
}

function doOverlayOpen() {
	//set status to open
	isOpen = true;
	showOverlayBox();
	$('.bgCover').css({opacity:0}).animate( {opacity:0.8, backgroundColor:'#000'} );
	// dont follow the link : so return false.
	return false;
}

function process_form_data(form) {
  var radios = document.getElementsByName('commentType');
  for (var i = 0, length = radios.length; i < length; i++) {
    if (radios[i].checked) {
        kind = radios[i].value;
    }
  }
  
  description = form.elements["comments"].value;
  var lat = markerPos.lat();
  var lon = markerPos.lng();
  
  if (userName === null) {
    userName = 'anonymous';
  }
  
  // Post data to server
  var url = "http://localhost/couchdb/hgt/_design/hgt/_update/tag/";
  
  var tag_obj = { "kind": kind, 
                  "lat":lat, 
                  "lon":lon, 
                  "expires":"2013-06-02T12:34:56Z",
                  "description": description, 
                  "username": userName};
  var str_data = JSON.stringify(tag_obj);
  
  $.ajax({
    type: "POST",
    url: url,
    data: str_data,
    success: function(response, result, request){
      console.log(result);
    },
    datatype: 'json',
    contentType: 'Application/json'
  });
}

function doOverlayClose(form) {
  //set status to closed
  isOpen = false;
  $('.overlayBox').css( 'display', 'none' );
  // now animate the background to fade out to opacity 0
  // and then hide it after the animation is complete.
  $('.bgCover').animate( {opacity:0}, null, null, function() { $(this).hide(); } );
  console.log("overlay closed");
  document.getElementById("panel").style.display="block";
  process_form_data(form);
  placeMarker(markerPos, map, description, kind);
}
// if window is resized then reposition the overlay box
$(window).bind('resize',showOverlayBox);
// activate when the link with class launchLink is clicked
$('a.launchLink').click( doOverlayOpen );
// close it when closeLink is clicked
$('a.closeLink').click( doOverlayClose );


function initialize() {
  var mapOptions = {
    zoom: 12,
    center: maseru,
    mapTypeId: google.maps.MapTypeId.HYBRID
  };
  
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  
  if (markerPlaced === true) {
    document.getElementById("panel").style.display="block";
  } else {
    document.getElementById("panel").style.display="none";
  }
  
  google.maps.event.addListener(map, 'click', function(e) {
    //placeMarker(e.latLng, map);
    markerPos = e.latLng;
    console.log('in listener ' + markerPos);
    if (markerPos !== null) {
      //Display Comment panel
      markerPlaced = true;
      document.getElementById("panel").style.display="block";
    } else {
      markerPlaced = false;
    }
  });
}
function makeInfoWindowEvent(map, infowindow, marker) {
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

