$(document).ready(function() {

    function renderDataTable() {
        $('#ordersList').dataTable({
            "rowCallback": function( row, data, index ) {
                if(index%2 == 0){
                    $(row).removeClass('myodd myeven');
                    $(row).addClass('myodd');
                }else{
                    $(row).removeClass('myodd myeven');
                     $(row).addClass('myeven');
                }
              }
        });
    }

    function handlebarsOrdersList(data) {
        $.get('../templates/ordersList.hbs')
            .done(function(templateData) {
                //console.log(templateData);
                var template = Handlebars.compile(templateData);
                var html = template(data);
                $('#ordersContainer').html(html);
                renderDataTable();
                console.log($.fn.dataTable);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }
    

    function fetchOrders(months) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getOrdersForAjax&months=' + months,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                console.log(data);
    
                if (data.length === 0) {
                    $('#ordersContainer').html('<p>No orders yet. Place your fist order !!</p>');
                } else {
                    handlebarsOrdersList(data);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error: ' + error);
                console.log('Response Text:', xhr.responseText);
                $('#ordersContainer').html('Error fetching data');
            }
        });
    }
    

        fetchOrders(1);
    
        $('#filterButton').click(function() {
            var selectedMonths = $('#monthsDropdown').val();
            fetchOrders(selectedMonths);
        });
    

    $('#exportOrders').click(function() {
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=exportOrdersToExcel',
            contentType: 'application/json',
            data: JSON.stringify({}),
            xhrFields: {
                responseType: 'blob'
            },
            success: function(data, status, xhr) {
                var blob = new Blob([data], { type: xhr.getResponseHeader('Content-Type') });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = 'orders.xlsx';
                link.click();
                window.URL.revokeObjectURL(link.href);
            },
            error: function(xhr, status, error) {
                console.error("Error downloading the file: " + error);
            }
        });
    });
    
    
});

function downloadInvoice(orderId) {
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=generateInvoice&orderId=' + orderId,
        method: 'GET',
        xhrFields: {
            responseType: 'blob'
        },
        success: function(data) {
            console.log("sending pdf details", data);
            const url = window.URL.createObjectURL(data);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'invoice_' + orderId + '.pdf';
            document.body.appendChild(a);
            a.click();
            a.remove();
            window.URL.revokeObjectURL(url); 
        },
        error: function(xhr, status, error) {
            console.error('Error downloading invoice:', error);
        }
    });
}