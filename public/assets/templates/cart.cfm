<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Mart</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="../../assets/js/index.js"></script>
    <script src="../../assets/js/cart.js"></script>

</head>
<body class="d-flex flex-column min-vh-100" style="height: 100%; padding-top: 100px;>
    
    <cfinclude template="header.cfm">


    <div class="container mb-5">
        <div class="d-flex flex-row align-items-start" id="cartPage">
            <div class="col-8 d-flex flex-column m-2" id="carItemsContainer">
                
            </div>


            <div class="col-4 order p-3 m-2" id="cartPayment" style="border: 1px solid grey;">
                <h4>Order Total</h4>

                <div class="d-flex flex-row justify-content-between p-2">
                    <input type="text" class="form-control" placeholder="Coupon code" id="couponCode">
                    <button class="btn btn-primary" id="applyCoupon">Apply</button>
                </div>

                <div class="d-flex flex-row justify-content-between p-2">
                    <span class="billing-items">Items Cost</span>
                    <span class="billing-cost">$0</span>
                </div>
                
                <div class="d-flex flex-row justify-content-between p-2">
                    <span class="billing-items">Shipping</span>
                    <span class="billing-cost">$0</span>
                </div>
                
                <div class="d-flex flex-row justify-content-between p-2">
                    <span class="billing-items">Discount</span>
                    <span class="billing-cost">-$0</span>
                </div>
                
                <div class="d-flex flex-row justify-content-between p-2">
                    <span class="billing-items fs-5">Total</span>
                    <span class="billing-cost fs-5">$0</span>
                </div>
                

                <div class="d-flex mt-3">
                    <button id="placeOrderButton" class="btn btn-primary flex-grow-1">Place Order</button>
                </div>
            </div>
        </div>


        
    </div>


    <cfinclude template="footer.cfm">


    <!-- Modal -->
    <div class="modal fade" id="removeItem" tabindex="-1" aria-labelledby="removeItemLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="removeItemLabel">Removing Item</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to remove this item from cart!?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">No</button>
                    <button type="button" class="btn btn-success" id="removeCartItem" data-bs-dismiss="modal">Yes</button>
                </div>
            </div>
        </div>
    </div>
    
    
</body>
</html>