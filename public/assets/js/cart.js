let isAddingToCart = false;
let cartTemplate;
let sessionId;


$(document).ready(function() {
    Handlebars.registerHelper('range', function(min, max) {
        var result = [];
        for (var i = min; i <= max; i++) {
            result.push(i);
        }
        return result;
    });

    Handlebars.registerHelper('eq', function(a, b) {
        return a === b;
    });

    $.get('../templates/cart.hbs', function(templateSource) {
        cartTemplate = Handlebars.compile(templateSource);
        loadCartItems();
    });
    

    $('#searchButton').click(function(e) {
        e.preventDefault(); 
        searchProducts();
    });

    $('#searchInput').on('input', function() {
        searchProducts();
    });

    function searchProducts() {
        let query = $('input[type="search"]').val().toLowerCase(); // Get the search input

        let foundAny = false; // Flag to track if any product was found

        // Reset the "No results found" message before applying new search
        $('#productsList').find('p.no-results').remove();

        // Loop through all categories and filter based on the search query
        $('#productsList .category').each(function() {
            let foundCategory = false; // Flag for checking if any product is found in this category

            // Get the category name (for search by category)
            let categoryName = $(this).find('.card-body .card-subtitle').text().toLowerCase();

            // Create an array to hold matched products
            let matchedProducts = [];

            // Loop through each product within the category
            $(this).find('.card').each(function() {
                let productName = $(this).find('.card-title').text().toLowerCase(); // Get product name

                // Check if product name or category matches the search query
                if (productName.includes(query) || categoryName.includes(query)) {
                    $(this).show(); // Show product if it matches the search
                    matchedProducts.push(this); // Add this product to the matched array
                    foundCategory = true;
                    foundAny = true;
                } else {
                    $(this).hide(); // Hide product if it doesn't match
                }
            });

            // If products in this category matched, reorder them
            if (foundCategory) {
                // Reorder the matched products at the top
                let $category = $(this);
                $.each(matchedProducts, function(index, product) {
                    $category.find('.row').prepend(product); // Move each matched product to the top of the category
                });
                $category.show(); // Show the category if it has matching products
            } else {
                $(this).hide(); // Hide the category if no product matches
            }
        });

        // If no products match, show "No results found" message
        if (!foundAny) {
            $('#productsList').append('<p class="no-results">No results found</p>');
        }
    }


});

$.ajax({
    url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getSessionId',
    method: 'GET',
    dataType: 'json',
    success: function(response) {
        console.log(response);
        sessionId = response;
    },
    error: function(xhr, status, error) {
        showAlert('Error fetching session ID: ' + error);
    }
});


$(document).on('click', '[id^="addToCartButton"]', function(event) {
    event.preventDefault();
console.log('Clicked:', event.target);
    if (isAddingToCart) return;

    isAddingToCart = true;

    var button = $(this);
    var productId = button.data('productid');
    var productName = button.data('productname');
    var price = button.data('productprice');
    var quantity = button.data('quantity');
    var productpath = button.data('productpath');

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

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=addToCart',
        method: 'POST',
        data: {
            productId: productId,
            productName: productName,
            price: price,
            quantity: quantity,
            productpath: productpath
        },
        success: function(response) {
            if (typeof response === "string") {
                response = JSON.parse(response);
            }

            console.log("Response:", response);

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
            
            if (response.SUCCESS) {
                console.log("this is from if", response);
                showAlert('success', response.MESSAGE);
                
                button.text('Added').removeClass('btn-outline-primary').addClass('btn-success');
                loadCartItems();
            } else {
                console.log("this is from else", response);
                showAlert('danger', 'Error: ' + response.MESSAGE);
            }
        },
        error: function(xhr, status, error) {
            showAlert('danger', 'Error adding item to cart: ' + xhr.responseText);
        },
        complete: function() {
            isAddingToCart = false;
        }
    });
    return false;
});


function loadCartItems() {
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getCartItems',
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("Session Cart Items:", response);
            $('#carItemsContainer').empty();
            if (response.length === 0) { 
                $('#cartPayment').hide();
                updateTotalCost();
                $('.billing-cost').text('$0.00');
                $('#carItemsContainer').html(`
                    <div class="d-flex justify-content-center align-items-center" 
                         style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); 
                                text-align: center; padding: 20px;">
                        <div>
                            <i class="fas fa-shopping-cart" style="font-size: 150px; color: gray;"></i>
                            <p style="font-size: 24px; color: #555; font-weight: bold; margin-top: 10px;">
                                No items in cart.
                            </p>
                        </div>
                    </div>
                `);
            } else {
                $('#cartPayment').show();
                var html = cartTemplate({ items: response });
                $('#carItemsContainer').html(html);
                updateTotalCost();
            }
        },
        error: function(xhr, status, error) {
            showAlert('danger', 'Error fetching cart items: ' + error);
        }
    });
}

function updateOrderSummary(items) {
    let totalItemsCost = 0;
    let shippingCost = 10;
    let discount = 10;
    console.log("from update", items);

    items.forEach(item => {
        totalItemsCost += item.PRICE * item.QUANTITY;
    });

    let totalCost = totalItemsCost + shippingCost - discount;

    $('.billing-cost').eq(0).text(`$${totalItemsCost}`);
    $('.billing-cost').eq(1).text(`$${shippingCost}`);
    $('.billing-cost').eq(2).text(`-$${discount}`);
    $('.billing-cost').eq(3).text(`$${totalCost}`);
}

$(document).on('click', '.close', function(event) {
    event.preventDefault();
    var productId = $(this).closest('.cart-item').data('productid');
    $('#removeItem').data('productid', productId); 
});


$(document).on('click', '#removeCartItem', function() {
    var productId = $('#removeItem').data('productid');

    if ($('#alertContainer').length === 0) {
        $('body').append('<div id="alertContainer" style="position: fixed; top: 60px; right: 20px; z-index: 1050;"></div>');
    }

    function showAlert(type, message) {
        const alertHtml = `
            <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                ${message}
                
            </div>
        `;
        
        $('#alertContainer').append(alertHtml);
        
        setTimeout(() => {
            $('.alert').alert('close');
        }, 5000);
    }

    if (productId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=removeFromCart',
            method: 'POST',
            data: { productId: productId },
            success: function(response) {
                showAlert('success', 'Item removed from cart!');
                loadCartItems();
                console.log("Cart Items after removal:", response); 
                updateTotalCost();
            },
            error: function(xhr, status, error) {
                showAlert('danger', 'Error removing item from cart: ' + error);
            }
        });
    } else {
        showAlert('danger', 'No product ID found.');
    }
});

$(document).on('change', '.quantity-select', function() {
    var selectedQuantity = parseInt($(this).val(), 10);
    var pricePerItem = parseFloat($(this).data('price'));
    var totalPrice = pricePerItem * selectedQuantity;

    $(this).closest('.cart-item').find('.item-price').text(totalPrice.toFixed(2));

    updateTotalCost();
});

function updateTotalCost() {
    let totalItemsCost = 0;
    console.log("Updating total cost...");
    $('.cart-item').each(function() {
        let quantity = parseInt($(this).find('.quantity-select').val(), 10); 
        let price = parseFloat($(this).find('.item-price').data('price')); 

        console.log("Quantity:", quantity, "Price:", price); 
        if (!isNaN(quantity) && !isNaN(price)) { 
            totalItemsCost += price * quantity;
        }
    });

    console.log("Total Items Cost:", totalItemsCost); 
    let shippingCost = 10;
    let discount = 10;

    let totalCost = totalItemsCost + shippingCost - discount;

    $('.billing-cost').eq(0).text(`$${totalItemsCost.toFixed(2)}`);
    $('.billing-cost').eq(1).text(`$${shippingCost.toFixed(2)}`); 
    $('.billing-cost').eq(2).text(`-$${discount.toFixed(2)}`); 
    $('.billing-cost').eq(3).text(`$${totalCost.toFixed(2)}`); 
}

$(document).on('click', '#placeOrderButton', function() {
    var totalAmount = parseFloat($('.billing-cost').eq(3).text().replace('$', ''));
    var customerId = parseInt(sessionId, 10);
    console.log("Customer ID:", customerId);

    if ($('#alertContainer').length === 0) {
        $('body').append('<div id="alertContainer" style="position: fixed; top: 60px; right: 20px; z-index: 1050;"></div>');
    }

    function showAlert(type, message) {
        const alertHtml = `
            <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                ${message}
                
            </div>
        `;
        
        $('#alertContainer').append(alertHtml);
        
        setTimeout(() => {
            $('.alert').alert('close');
        }, 5000);
    }
    
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=placeOrder',
        method: 'POST',
        data: {
            customerId: customerId, 
            totalAmount: totalAmount
        },
        success: function(response) {
            console.log("Response form place order:", response);

            if (typeof response === "string") {
                response = JSON.parse(response);
            }
            
            if (response.SUCCESS) {
                loadCartItems();
                window.location.href = 'orderSuccess.cfm';
            } else {
                showAlert('danger',response.MESSAGE);
            }
        },
        error: function(xhr, status, error) {
            showAlert('danger','Error placing order: ' + error);
        }
    });
});

$('#navProfile').click(function(event) {
    event.preventDefault(); 
    const userId = $(this).data('userid'); 
    console.log("userId for profile", userId);
    if (userId) {
        window.location.href = 'profile.cfm?userId=' + userId; 
        console.log("userId for profile", userId);
    } else {
        showAlert('danger','User ID not found!');
    }
});
