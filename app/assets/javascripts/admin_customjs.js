 $(document).ready(function(){
 	$( "#flight_assignment_arrival_date, #flight_assignment_departure_date" ).prop('readonly',true)
$( "#flight_assignment_arrival_date, #flight_assignment_departure_date" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: 'dd/mm/yy'
    });
})

