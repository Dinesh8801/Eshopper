let isAddingToCart = false;
let cartTemplate;
let sessionId;

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
		let query = $('#searchBar').val().toLowerCase();

		let foundAny = false;

		$('#productsList').find('p.no-results').remove();

		$('#productsList .category').each(function() {
			let foundCategory = false;

			let categoryName = $(this).find('.card-body .card-subtitle').text().toLowerCase();

			let matchedProducts = [];

			$(this).find('.card').each(function() {
				let productName = $(this).find('.card-title').text().toLowerCase();

				if (productName.includes(query) || categoryName.includes(query)) {
					$(this).show(); 
					matchedProducts.push(this);
					foundCategory = true;
					foundAny = true;
				} else {
					$(this).hide();
				}
			});

			if (foundCategory) {
				let $category = $(this);
				$.each(matchedProducts, function(index, product) {
					$category.find('.row').prepend(product);
				});
				$category.show();
			} else {
				$(this).hide();
			}
		});

		if (!foundAny) {
			$('#productsList').append('<h3 class="no-results" style="position: absolute; top: 50%; left: 8%; text-align: center;">Oops! We couldn’t find what you were looking for.</h3>');
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

var appliedDiscount = 0;
$(document).on('click', '#applyCoupon', function() {
	var couponCode = $('#couponCode').val();

	if (!couponCode) {
		showAlert('danger', 'Please enter a coupon code');
		resetDiscount();
		updateTotalCost(0);
		return;
	}

	$.ajax({
		url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=applyCoupon',
		method: 'POST',
		dataType: 'JSON',
		data: { couponCode: couponCode },
		success: function(response) {
			console.log( response.SUCCESS);
			console.log( response);

			if (response && response.SUCCESS) {
				appliedDiscount = response.DISCOUNT;
				console.log(appliedDiscount);
				showAlert('success', 'Coupon applied successfully!');
				updateTotalCost(appliedDiscount);
			} else {
				resetDiscount();
				showAlert('danger', 'Invalid coupon code!');
				updateTotalCost(0);
			}
		},
		error: function(xhr, status, error) {
			showAlert('danger', 'Error applying coupon: ' + error);
		}
	});
});

function resetDiscount() {
	console.log("Resetting discount...");

	$('.billing-cost').eq(2).text('-Rs0.00');
}


function loadCartItems() {
	$.ajax({
		url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getCartItems',
		method: 'GET',
		dataType: 'json',
		success: function(response) {
			console.log("Session Cart Items:", response);
			$('#carItemsContainer').empty();
			$('#cartCount').text(response.length);
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

$(document).on('click', '.close', function(event) {
	event.preventDefault();
	var productId = $(this).closest('.cart-item').data('productid');
	$('#removeItem').data('productid', productId); 
});


$(document).on('click', '#removeCartItem', function() {
	var productId = $('#removeItem').data('productid');

	

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

function updateTotalCost(discountAmount = appliedDiscount) {
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

	discountAmount = isNaN(discountAmount) ? 0 : discountAmount;

	let totalCost = totalItemsCost + shippingCost - discountAmount;

	$('.billing-cost').eq(0).text(`$${totalItemsCost.toFixed(2)}`);
	$('.billing-cost').eq(1).text(`$${shippingCost.toFixed(2)}`);
	$('.billing-cost').eq(2).text(`-$${discountAmount.toFixed(2)}`);
	$('.billing-cost').eq(3).text(`$${totalCost.toFixed(2)}`);
}


$(document).on('click', '#placeOrderButton', function() {
	var totalAmount = parseFloat($('.billing-cost').eq(3).text().replace('$', ''));
	var customerId = parseInt(sessionId, 10);
	console.log("Customer ID:", customerId);

	
	
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
