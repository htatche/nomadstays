var ready = function() {
  console.log("yay");

  if ($("#stay_search").length > 0) {

    $("#q_full_address_cont").geocomplete();

    // Trigger geocoding request.
    $("button.find").click(function(){
      $("#q_full_address_cont").trigger("geocode");
    });

  }

}

$(document).ready(ready);
$(document).on('page:load', ready);  