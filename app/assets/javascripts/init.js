$.fn.datepicker.defaults.format = "dd/mm/yyyy";
$.fn.datepicker.defaults.weekStart = 1;

function renderAvailabilityCalendar (element_class) {

  $(element_class).datepicker({
    
    beforeShowDay: function(date) {   

      var dateFormat = moment(new Date(date));

      for (var i=0; i<booked_dates.length; ++i) {

        var from = moment(booked_dates[i][0], 'DD/MM/YYYY');
        var to = moment(booked_dates[i][1], 'DD/MM/YYYY');

        var inRange  = dateFormat.isBetween(from, to);
        var sameDate = dateFormat.isSame(from) || dateFormat.isSame(to);

        if (inRange || sameDate) {
          return {enabled: false}; 
        }   
      }
    }
    // beforeShowMonth: function() {   
    //   // Re-apply CSS for unfolding calendar
    //   console.log('asd');
    //   $('.datepicker').addClass('availability-calendar');
    // }    
  })
  
}