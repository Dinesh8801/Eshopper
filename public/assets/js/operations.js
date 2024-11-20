$(document).ready(function() {

    $(document).on('click', '#submitPasswordReset', function(event) {
        event.preventDefault();
        console.log("Submit Button Pressed.")
        var username = $('#username').val();
        var newPassword = $('#newPassword').val();

        if ($('#alertContainer').length === 0) {
            $('body').append('<div id="alertContainer" style="position: fixed; top: 60px; right: 20px; z-index: 1050;"></div>');
        }
    
        function showAlert(type, message) {
            const alertHtml = `
                <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            `;
            
            $('#alertContainer').append(alertHtml);
            
            setTimeout(() => {
                $('.alert').alert('close');
            }, 5000);
        }
    

        if (!username) {
            showAlert('danger',"Username is required.");
            return;
        }
        if (!newPassword) {
            showAlert('danger',"Password is required.");
            return;
        }

        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=updatePasswordReset',
            type: 'POST',
            dataType: 'json',
            data: {
                username: username,
                newPassword: newPassword
            },
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('success',response.MESSAGE, "success");
                } else {
                    showAlert('danger',"Error: " + response.MESSAGE, "danger");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                showAlert('danger',"AJAX Error: " + textStatus + ": " + errorThrown, "danger");
            }
        });
    });

    var userId = getUrlParameter('userID');
    console.log('User ID:', userId);

    if (!isNaN(userId) && userId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getUserById&userId=' + userId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('User Response:', response);
                if (response && response.userId) {
                    displayUserData(response);
                } else {
                    console.error('Invalid user response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('User AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid user ID');
    }

    var productId = getUrlParameter('productID');
    console.log('Product ID:', productId);

    if (!isNaN(productId) && productId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getProductById&productId=' + productId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('Product Response:', response);
                if (response && response.productId) {
                    displayProductData(response);
                } else {
                    console.error('Invalid product response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('Product AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid product ID');
    }

    
});

var orderId = getUrlParameter('Saleid'); 
console.log('Order ID:', orderId);

if (!isNaN(orderId) && orderId) { 
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getOrderById&saleId=' + orderId,
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log('Response:', response);
            if (response && response.SaleID) {
                displayOrderData(response);
            } else {
                console.error('Invalid response format:', response);
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', error);
        }
    });
} else {
    console.error('Invalid order ID');
}

var categoryId = getUrlParameter('CategoryID');
    console.log('Category ID:', categoryId);
    
    if (!isNaN(categoryId) && categoryId) { 
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getCategoryById&categoryId=' + categoryId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('Response:', response);
                if (response && response.categoryId) {
                    $('#categoryName').val(response.categoryName);
                } else {
                    console.error('Invalid response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid category ID');
    }

function displayOrderData(order) {
$('#saleId').val(order.SaleID);
$('#customerId').val(order.CustomerID);
$('#saleDate').val(order.SaleDate);
$('#productId').val(order.ProductID);
$('#productName').val(order.ProductName);
$('#quantity').val(order.Quantity);
$('#price').val(order.Price);
$('#totalAmount').val(order.TotalAmount);
$('#status').val(order.Status);
}

function displayUserData(user) {
    $('#userId').val(user.userId);
    $('#firstname').val(user.firstname);
    $('#lastname').val(user.lastname);
    $('#username').val(user.username);
    $('#password').val(user.password);
    $('#userrole').val(user.userrole);
    $('#email').val(user.email);
    $('#address').val(user.address);
    $('#country').val(user.country);
    $('#state').val(user.state);
    $('#zip').val(user.zip);
}

function displayProductData(product) {
    $('#productId').val(product.productId);
    $('#category').val(product.category);
    $('#productName').val(product.productName);
    $('#price').val(product.price);
    $('#stockQuantity').val(product.stockQuantity);
    $('#productPath').val(product.productPath);
}

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(window.location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

