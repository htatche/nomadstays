// TODO: Conver this and the rest of JS files to new ES6 modules :-P

var NewBookingView = function() {

  var parent = this;

}

NewBookingView.prototype.read_dom_events = function() {
  var parent = this;

  $("#extra-services :checkbox").change(function(e) {
    var input = $("." + e.target.id + "_price");

    if (this.checked) {
      input.show();
    } else {
      input.hide();
    }

  });  

}  

NewBookingView.prototype.show_input = function(id, checked) {


}

NewBookingView.prototype.ready = function() {
  var parent = this;

  if ($("#new_booking").length > 0) {
    parent.read_dom_events();
  }

}

var new_booking_form = new NewBookingView();

$(document).ready(new_booking_form.ready.bind(new_booking_form));
$(document).on('page:load', new_booking_form.ready.bind(new_booking_form));  