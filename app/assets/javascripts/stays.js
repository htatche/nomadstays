// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).ready(function() {
	handler = Gmaps.build('Google');
	handler.buildMap({ provider: {}, internal: {id: 'map'} }, function(){
	  markers = handler.addMarkers([
	    {
	      "lat": -17.3940401,
	      "lng": -66.1638756,
	      "picture": {
	        // "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
	        "width":  36,
	        "height": 36
	      },
	      "infowindow": "hello!"
	    }
	  ]);
	  handler.bounds.extendWith(markers);
	  handler.fitMapToBounds();
	  handler.getMap().setZoom(15);
	});
});

      // var mapOptions = { 
      //   center: { lat: 19.528582, lng: 7.975645}
      //   zoom: 2
      // };
      // var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);