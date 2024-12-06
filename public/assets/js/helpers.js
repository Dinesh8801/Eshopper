$(document).ready(function() {
    console.log('daterange picker');
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
});