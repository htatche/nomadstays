// TODO: Conver this and the rest of JS files to new ES6 modules :-P

var NewBookingView = function() {

  var parent = this;

}

NewBookingView.prototype.read_dom_events = function(extra_services_els, select_length_el) {
  var parent = this;

  // Show / hide price of extra services
  extra_services_els.change(function(e) {
    var input = $("." + e.target.id + "_price");

    if (this.checked) {
      input.show();
    } else {
      input.hide();
    }

    parent.update_bill_services.call(this);
  }); 

  select_length_el.change(function() { 
    parent.update_bill_length.call(this);
  });
}  

// Show / hide selected services on the bill
NewBookingView.prototype.update_bill_services = function() {
  $("#extra-services input[type=checkbox]").each(function() {
    if (this.checked) {
      $("#bill #" + this.id).show();
    } else {
      $("#bill #" + this.id).hide();
    }
  })
}

// Calculate Length of the stay on the bill (in months)
NewBookingView.prototype.update_bill_length = function() {
  var selected_option = $(this).find(":selected");

  $("#bill #stay_length").html(selected_option.text());

  var date_from = $("#booking_date_from").val();
  $("#bill #date_from").html(date_from);    
  
  var m = moment(date_from, "DD/MM/YYYY");
  var date_to = m.add(selected_option.val(), 'months').format('DD/MM/YYYY');
  $("#bill #date_to").html(date_to);  
}

NewBookingView.prototype.ready = function() {
  var parent = this;

  if ($("#new_booking").length > 0) {
    var select_length_el = $("#booking_stay_length_in_months");
    var extra_services_els = $("#extra-services :checkbox");

    parent.update_bill_length.call(select_length_el);
    parent.read_dom_events(extra_services_els, select_length_el);
  }

}

var new_booking_form = new NewBookingView();

$(document).ready(new_booking_form.ready.bind(new_booking_form));
$(document).on('page:load', new_booking_form.ready.bind(new_booking_form));  