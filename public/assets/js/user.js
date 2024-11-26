$(document).ready(function() {

	$('#dateRange').daterangepicker({
        autoUpdateInput: false,
        locale: {
            cancelLabel: 'Clear',
            format: 'YYYY-MM-DD'
        }
    });

    // When a date range is selected
    $('#dateRange').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(picker.startDate.format('YYYY-MM-DD') + ' to ' + picker.endDate.format('YYYY-MM-DD'));
    });

    // When the user clears the selected date range
    $('#dateRange').on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });

	$.ajax({
		url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=getUserBySession',
		method: 'GET',
		dataType: 'json',
		success: function(response) {
			const userId = Object.keys(response)[0];
			const user = response[userId];
			console.log('User Response:', response);
			if (user) {
				displayCustomerData(user);
			} else {
				console.error('Invalid user response format:', response);
			}
		},
		error: function(xhr, status, error) {
			console.error('User AJAX Error:', error);
		}
	});

	
});

function displayCustomerData(user) {
	$('#firstname').val(user.FIRSTNAME);
	$('#lastname').val(user.LASTNAME);
	$('#username').val(user.USERNAME);
	$('#password').val(user.PASSWORD);
	$('#email').val(user.EMAIL);
	$('#address').val(user.ADDRESS);
	$('#country').val(user.COUNTRY);
	$('#state').val(user.STATE);
	$('#zip').val(user.ZIP);
}