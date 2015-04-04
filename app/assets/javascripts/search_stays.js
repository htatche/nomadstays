$( document ).ready(function() {
  $("input").geocomplete();

  // Trigger geocoding request.
  $("button.find").click(function(){
    $("input").trigger("geocode");
  });
});