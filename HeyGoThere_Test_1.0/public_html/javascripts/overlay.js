/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

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
  $overlay_tag_location.
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