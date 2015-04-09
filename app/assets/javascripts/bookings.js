// TODO: Conver this and the rest of JS files to new ES6 modules :-P

var NewBookingView = function() {

  var parent = this;

}

// Calculate length of the stay on the bill (in months)
NewBookingView.prototype.update_bill_length = function() {
  var selected_option = $(this).find(":selected");
  var date_from       = $("#booking_date_from").val();
  var m               = moment(date_from, "DD/MM/YYYY");
  var date_to         = m.add(selected_option.val(), 'months').format('DD/MM/YYYY');

  $("#bill #stay_length").html(selected_option.text());
  $("#bill #date_from").html(date_from);    
  $("#bill #date_to").html(date_to);  
}

// Show / hide selected services on the bill
NewBookingView.prototype.update_bill_services = function() {
  $("#extra-services input[type=checkbox]").each(function() {
    if (this.checked) {
      $("#bill #" + this.id).addClass("selected");
      $("#bill #" + this.id).show();
    } else {
      $("#bill #" + this.id).removeClass("selected");
      $("#bill #" + this.id).hide();
    }
  })
}

// Calculate total of the bill
NewBookingView.prototype.update_bill_total = function() {
  var selected_option = $(this).find(":selected");
  var total = 0;

  // Stay price
  total = total + parseInt($("#bill #stay_price").html());

  // Extra services sum
  $(".extra-service.selected td:nth-child(2)").each(function(index,value) {
    var html = $(value).html();
    total = total + parseInt(html);
  })  

  total = total * parseInt(selected_option.val());

  $("#bill #total #months").html(selected_option.text());
  $("#bill #total #pricetag").html(total);
}

NewBookingView.prototype.read_dom_events = function(extra_services_els, select_length_el, date_from_el) {
  var parent = this;

  extra_services_els.change(function(e) {
    var input = $("." + e.target.id + "_price");

    if (this.checked) {
      input.show();
    } else {
      input.hide();
    }

    parent.update_bill_services.call(this);
    parent.update_bill_total.call(select_length_el);
  }); 

  date_from_el
  .add(select_length_el)
  .change(function() { 
    parent.update_bill_length.call(select_length_el);
    parent.update_bill_total.call(select_length_el);
  });
}  

NewBookingView.prototype.ready = function() {
  var parent = this;

  if ($("#new_booking").length > 0) {
    var select_length_el = $("#booking_stay_length_in_months");
    var extra_services_els = $("#extra-services :checkbox");
    var date_from_el = $("#booking_date_from"); 

    parent.update_bill_length.call(select_length_el);
    parent.update_bill_total.call(select_length_el);
    parent.read_dom_events(extra_services_els, select_length_el, date_from_el);

    renderAvailabilityCalendar(".availability-calendar");  
  }

}

var new_booking_form = new NewBookingView();

$(document).ready(new_booking_form.ready.bind(new_booking_form));
$(document).on('page:load', new_booking_form.ready.bind(new_booking_form));  