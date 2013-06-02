/* 
 * Facebook Handler
 * Defines functions needed to interact with Facebook API
 * 
 */

var access_token;
var userID;
//var url = "http://heygothere.house4hack.co.za/couchdb/hgt/_design/hgt/_update/user/";
var url = "http://localhost/couchdb/hgt/_design/hgt/_update/user/";
        
window.fbAsyncInit = function() {ReferenceError
FB.init({
  appId      : '466740713411967', // App ID
  //channelUrl : '//localhost:8383/HeyGoThere_Test_1/channel.html', // Channel File
  status     : true, // check login status
  cookie     : true, // enable cookies to allow the server to access the session
  xfbml      : true  // parse XFBML
});

// Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
// for any authentication related change, such as login, logout or session refresh. This means that
// whenever someone who was previously logged out tries to log in again, the correct case below 
// will be handled. 

FB.Event.subscribe('auth.authResponseChange', function(response) {
  // Here we specify what we do with the response anytime this event occurs. 
  if (response.status === 'connected') {
    // If user successfully connects to the app, send the data to server
    // and turn the login button off
    sendToServer();
    document.getElementById("fb_login_btn").style.display="none";
  } else if (response.status === 'not_authorized') {
    // In case the user does not authorize the app display
    // relevant page

    // TODO - add code to redirect user
    // 
    //FB.login();
  } else {
    // In this case, the person is not logged into Facebook
    // Display the login button
    document.getElementById("fb_login_btn").style.display="block";
    //FB.login();
  }
});
};


// Load the SDK asynchronously
(function(d){
 var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
 if (d.getElementById(id)) {return;}
 js = d.createElement('script'); js.id = id; js.async = true;
 js.src = "//connect.facebook.net/en_US/all.js";
 ref.parentNode.insertBefore(js, ref);
}(document));

// Here we run a very simple test of the Graph API after login is successful. 
// This testAPI() function is only called in those cases. 
function sendToServer() {    
  access_token = FB.getAuthResponse()['accessToken'];
  userID = FB.getAuthResponse()['userID'];
  
  console.log('Welcome!  Fetching your information.... ');
  console.log('Access Token = ' + access_token);
  console.log('User ID = ' + userID);
  FB.api('/me', function(response) {
    console.log('Good to see you, ' + response.name + '.');
  });
  
  var user_obj = { token: access_token };
  var str_token = JSON.stringify(user_obj);
  
  $.ajax({
    type: "POST",
    url: url + userID,
    data: str_token,
    success: function(response, result, request){
      console.log(result);
    },
    datatype: 'json',
    contentType: 'Application/json'
  });
}