component {
    remote struct function getProductsByCategory(required string categories) returnFormat="JSON" {
        var productService = new model.Products();
        return productService.getProductsByCategory(categories=arguments.categories);
    }

    remote function getCategories() returnFormat="JSON" {
        var productService = new model.Products();
        return productService.getCategories();
    }

    remote struct function getOrdersForAjax(required numeric months) returnFormat="JSON" {
        var productService = new model.Products();
        return productService.getOrdersForAjax(months=arguments.months);
    }

    remote struct function addToCart(required string productId, required string productName, required numeric price, required numeric quantity, required string productpath) returnformat="JSON" {
        var productService = new model.Products();
        return productService.addToCart(productId=arguments.productId, productName=arguments.productName, price=arguments.price, quantity=arguments.quantity, productpath=arguments.productpath);
    }

    remote array function getCartItems() returnFormat="JSON" {
        var productService = new model.Products();
        return productService.getCartItems();
    }

    remote void function removeFromCart(required string productId) { 
        var productService = new model.Products();
        return productService.removeFromCart(productId=arguments.productId);
    }

    remote struct function applyCoupon(required string couponCode) returnFormat="JSON" {
        var productService = new model.Products();
        return productService.applyCoupon(couponCode=arguments.couponCode);
    }

    remote struct function placeOrder(required numeric customerId, required numeric totalAmount) returnformat="JSON" {
        var productService = new model.Products();
        return productService.placeOrder(customerId=arguments.customerId, totalAmount=arguments.totalAmount);
    }
}
