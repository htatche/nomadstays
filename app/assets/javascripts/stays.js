/*
 * New view
 */

var map, marker, loc, lat, lng;

function build_map (latitude, longitude) {
  if (arguments.length == 0) {
    var latitude  = -12.043333;
    var longitude = -77.028333;
  }

  return new GMaps({
    el: '#map',
    lat: latitude,
    lng: longitude,
    zoom: 5
  }); 
}

function detect_map_click (argument) {

  GMaps.on('click', map.map, function(event) {
    update_marker(event.latLng);
  }); 
}   

function update_marker (latlng) {

  lat = latlng.lat();
  lng = latlng.lng();

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

  $("#stay_latitude").val(lat);
  $("#stay_longitude").val(lng);

}

function detect_user_input () {
  $("#stay_country").change(function() {
    pickup_location();
  });

  // TODO: Fire also on "change" event
  $("#stay_state").keypress(function() {
    pickup_location();
  });

  $("#stay_city").keypress(function() {
    pickup_location();
  });

  $("#stay_street_address").keypress(function() {
    pickup_location();
  }); 
}

function pickup_location () {
  var full_address;

  loc = {
    country: $("#stay_country :selected").text().split(",")[0],
    state:   $("#stay_state").val(),
    city:    $("#stay_city").val(),
    address: $("#stay_street_address").val()
  }

  full_address = loc.address + "," + loc.city + "," + loc.state + "," + loc.country;

  update_position(full_address);
}

function update_position (full_address) {
  GMaps.geocode({
    address: full_address,
    callback: function(results, status) {
      if (status == 'OK') {
        var latlng = results[0].geometry.location;
        update_marker(latlng);
      }
    }
  });
}

function read_dom_events() {
  $("#stay_accomodation_type").change(function() {
    show_accomodation_fields();
  })

  $("#extra-services :checkbox").change(function(e) {
    var input = $("." + e.target.id + "_price");

    if (this.checked) {
      input.show();
    } else {
      input.hide();
    }

  });  

}

function show_accomodation_fields () {
  var option = $("#stay_accomodation_type :selected").val() ||
               $("#stay_accomodation_type").val();

  switch (option) {
    case "Apartment":
      $("#accomodation_is_apartment").show();
      $("#accomodation_is_house").hide();
      $("#accomodation_is_room").hide();
      $("#form-details").show();    
      break;

    case "House":
      $("#accomodation_is_house").show();
      $("#accomodation_is_apartment").hide();
      $("#accomodation_is_room").hide();
      $("#form-details").show();    
      break;

    case "Room":
      $("#accomodation_is_room").show();
      $("#accomodation_is_house").hide();
      $("#accomodation_is_apartment").hide();  
      $("#form-details").hide();    
      break;

    default:
      $("#accomodation_is_apartment").hide();
      $("#accomodation_is_house").hide();    
      $("#accomodation_is_room").hide(); 
  }
}

/*
 * Show view
 */

// function showAvailabilityCalendar () {

//   $('#availability-calendar').datepicker({
//     beforeShowDay: function(date) {   

//       var dateFormat = moment(new Date(date));

//       for (var i=0; i<booking_dates.length; ++i) {

//         var from = moment(booking_dates[i][0], 'DD/MM/YYYY');
//         var to = moment(booking_dates[i][1], 'DD/MM/YYYY');

//         var inRange  = dateFormat.isBetween(from, to);
//         var sameDate = dateFormat.isSame(from) || dateFormat.isSame(to);

//         if (inRange || sameDate) {
//           return {classes: 'alert alert-danger'}; 
//         }   

//       }

//     }

//   })
// }

var ready = function() {

  if ($("#new_stay").length > 0) {
    map = build_map();

    marker = map.addMarker({
      lat: -12.043333,
      lng: -77.028333
    });

    detect_user_input(map);
    detect_map_click();   

    show_accomodation_fields();
    read_dom_events();
  }

  if ($(".edit_stay").length > 0) {
    var latitude  = parseFloat($("#stay_latitude").val());
    var longitude = parseFloat($("#stay_longitude").val());

    map = build_map(latitude, longitude);

    marker = map.addMarker({
      lat: latitude,
      lng: longitude
    });

    detect_user_input(map);
    detect_map_click();   

    show_accomodation_fields();
  }  

  if ($("#show-stay").length > 0) {
    renderAvailabilityCalendar(".availability-calendar");  
  }
  
};

$(document).ready(ready);
$(document).on('page:load', ready);  

$('#sandbox-container div').datepicker({
    format: "dd/mm/yyyy",
    weekStart: 1
});