 $(document).ready(function(){
 	$( "#flight_assignment_arrival_date, #flight_assignment_departure_date" ).prop('readonly',true)
	$( "#flight_assignment_arrival_date, #flight_assignment_departure_date" ).datepicker({
	      changeMonth: true,
	      changeYear: true,
	      dateFormat: 'dd/mm/yy'
	    });

	$('.flight_configuration').validate({
        rules: {
            "flight_configuration[seat_category_id]": {
                required: true,
            },
            "flight_configuration[number_of_row]": {
                required: true,
            },
            "flight_configuration[seat_in_row]": {
                required: true,
            },
            "flight_configuration[seat_base_price]": {
                required: true,
            },
        }
    });

     $('.flight').validate({
        rules: {
            "flight[name]": {
                required: true,
            },
            "flight[code]": {
                required: true,
            },
            
        }
    });

       $('.flight_assignment').validate({
        rules: {
            "flight_assignment[flight_id]": {
                required: true,
            },
            "flight_assignment[source_id]": {
                required: true,
            },
            
            "flight_assignment[destination_id]": {
                required: true,
            },
            "flight_assignment[arrival_date]": {
                required: true,
            },
            "flight_assignment[arrival_time]": {
                required: true,
            },
            "flight_assignment[departure_date]": {
                required: true,
            },
            "flight_assignment[departure_time]": {
                required: true,
            },
            "flight_assignment[flight_id]": {
                required: true,
            }
        }
    });

})

