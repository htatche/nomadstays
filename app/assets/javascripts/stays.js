var map, marker, loc, lat, lng;

function build_map () {
  return new GMaps({
    el: '#map',
    lat: -12.043333,
    lng: -77.028333,
    zoom: 5
  });	
}

function detect_map_click (argument) {

  GMaps.on('click', map.map, function(event) {
    var lat = event.latLng.lat();
    var lng = event.latLng.lng();

		marker.setPosition({
		  lat: lat,
		  lng: lng
		});    

  });    

}
function detect_user_input () {
	$("#stay_country").change(function() {
		pickup_location();
	});

	$("#stay_state").keypress(function() {
		pickup_location();
	});

	$("#stay_city").keypress(function() {
		pickup_location();
	});

	$("#stay_full_street_address").keypress(function() {
		pickup_location();
	});	
}

function pickup_location () {
	var full_address;

	loc = {
		country: $("#stay_country :selected").text().split(",")[0],
		state: 	 $("#stay_state").val(),
		city:    $("#stay_city").val(),
		address: $("#stay_full_street_address").val()
	}

	full_address = loc.address + "," + loc.city + "," + loc.state + "," + loc.country;

	update_position(full_address);
}

function update_position (full_address) {
	GMaps.geocode({
	  address: full_address,
	  callback: function(results, status) {
	    if (status == 'OK') {
	    	update_marker(results);
	    }
	  }
	});
}

function update_marker (results) {
	var latlng = results[0].geometry.location;

	map.setCenter(latlng.lat(), latlng.lng());
	marker.setPosition({
	  lat: latlng.lat(),
	  lng: latlng.lng()
	});

	if (loc.address !== "") {
		map.setZoom(18);
	} else if (loc.city !== "") {
		map.setZoom(14);
	} else if (loc.state !== "") {
		map.setZoom(10);
	} else if (loc.country !== "") {
		map.setZoom(5);
	}

}

$( document ).ready(function() {

	if ($(".new_stay .map_container")) {
		map = build_map();

		marker = map.addMarker({
	  	lat: -12.043333,
	  	lng: -77.028333
		});

		detect_user_input(map);
		detect_map_click();
	}

});