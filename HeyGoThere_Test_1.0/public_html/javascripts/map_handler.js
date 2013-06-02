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


/*
if (map !== null) {
  // Listen to click event on the map and place a marker at the location
  google.maps.event.addListener(map, 'click', function(e) {
    placeMarker(e.latLng, map);
  });
}
*/
/*
var $overlay_wrapper;
var $overlay_tag_location;

function show_overlay() {
  if ( !$overlay_wrapper ) append_overlay();
  $overlay_wrapper.fadeIn(700);
}

function hide_overlay() {
  $overlay_wrapper.fadeOut(500);
}

function append_overlay() {
  $overlay_wrapper = $('<div id="overlay"></div>').appendTo( $('BODY') );
  $$overlay_tag_location = $('<div id="overlay-tag-location">').appendTo( $overlay_wrapper );
  //$overlay_tag_location.
  $overlay_tag_location.html( '<a href=#>TODO Insert HTML Form here</a>');
}

$(function() {
  $('A.show-overlay').click( function(ev) {
    ev.preventDefault();
    show_overlay();
  });
});

function attach_overlay_event() {
  $('A.hide-overlay', $overlay_wrapper).click( function(ev) {
    ev.preventDefault();
    hide_overlay();
  });
}
*/


// Place marker at a given location on the map
function placeMarker(position, map) {
  var marker = new google.maps.Marker({
    position: position,
    map: map
  });
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

function doOverlayClose() {
	//set status to closed
	isOpen = false;
	$('.overlayBox').css( 'display', 'none' );
	// now animate the background to fade out to opacity 0
	// and then hide it after the animation is complete.
	$('.bgCover').animate( {opacity:0}, null, null, function() { $(this).hide(); } );
    console.log("overlay closed");
    document.getElementById("panel").style.display="block";
    placeMarker(markerPos, map);
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
      //ocument.getElementById("panel").style.display="none";
    }
    //doOverlayOpen();
    //show_overlay();
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

