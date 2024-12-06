component {
	remote string function AdminloginForAjax(string username, string password) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.AdminloginForAjax(username=arguments.username, password=arguments.password);
    }

    remote struct function getCategoriesReport() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getCategoriesReport();
    }

    remote struct function addUser(string username, string password, string email, string role) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.addUser(username=arguments.username, password=arguments.password, email=arguments.email, role=arguments.role);
    }

    remote struct function addProduct( string productName, string category, numeric price, numeric stockQuantity, any productFile) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.addProduct(productName=arguments.productName, category=arguments.category, price=arguments.price, stockQuantity=arguments.stockQuantity, productFile=arguments.productFile);
    }

    remote struct function addCategory(string categoryName) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.addCategory(categoryName=arguments.categoryName);
    }

    remote struct function addCoupon(string couponCode, numeric discount) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.addCoupon(couponCode=arguments.couponCode, discount=arguments.discount);
    }

    remote struct function getUsersForAdmin() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getUsersForAdmin();
    }

    remote struct function getCategoriesForAdmin() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getCategoriesForAdmin();
    }

    remote struct function getProductsForAdmin() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getProductsForAdmin();
    }

    remote struct function getOrdersForAdmin() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getOrdersForAdmin();
    }

    remote struct function getCouponsForAdmin() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getCouponsForAdmin();
    }

    remote struct function getUserById(numeric userId) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getUserById(userId=arguments.userId);
    }

    remote struct function getProductById(numeric productId) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getProductById(productId=arguments.productId);
    }

    remote struct function getOrderById(numeric saleId) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getOrderById(saleId=arguments.saleId);
    }

    remote struct function getCategoryById(numeric categoryId) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getCategoryById(categoryId=arguments.categoryId);
    }

    remote struct function getCouponById(numeric couponId) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.getCouponById(couponId=arguments.couponId);
    }

    remote struct function deleteUser() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.deleteUser();
    }

    remote struct function deleteProduct() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.deleteProduct();
    }

    remote struct function deleteCategory() returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.deleteCategory();
    }

    remote struct function deleteCoupon(numeric couponId) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.deleteCoupon(couponId=arguments.couponId);
    }

    remote struct function updateUser(string firstname,string lastname,string username, string address, string email, string password, string userrole, string country, string state, string zip) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.updateUser(firstname=arguments.firstname, lastname=arguments.lastname, username=arguments.username, address=arguments.address, email=arguments.email, password=arguments.password, userrole=arguments.userrole, country=arguments.country, state=arguments.state, zip=arguments.zip);
    }

    remote struct function updateCategory(numeric categoryId, string categoryName) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.updateCategory(categoryId=arguments.categoryId, categoryName=arguments.categoryName);
    }

    remote struct function updateProduct(numeric productId, string category, string productName, numeric price, numeric stockQuantity, any fileUpload) returnformat="JSON" {
        var adminService = new model.Adminuser();
        if (structKeyExists(arguments, "fileUpload")) {
            return adminService.updateProduct(productId=arguments.productId, category=arguments.category, productName=arguments.productName ,price=arguments.price, stockQuantity=arguments.stockQuantity, fileUpload=arguments.fileUpload);
        } else {
            return adminService.updateProduct(productId=arguments.productId, category=arguments.category, productName=arguments.productName ,price=arguments.price, stockQuantity=arguments.stockQuantity);
        }
        
    }

    remote struct function updateOrder(numeric saleId, numeric customerId, date saleDate, numeric productId, string productName, numeric quantity, numeric price, numeric totalAmount, string status) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.updateOrder(saleId=arguments.saleId, customerId=arguments.customerId, saleDate=arguments.saleDate, productId=arguments.productId, productName=arguments.productName, quantity=arguments.quantity, price=arguments.price, totalAmount=arguments.totalAmount, status=arguments.status);
    }

    remote struct function updateCoupon(numeric couponId, string couponCode, numeric discount) returnformat="JSON" {
        var adminService = new model.Adminuser();
        return adminService.updateCoupon(couponId=arguments.couponId, couponCode=arguments.couponCode, discount=arguments.discount);
    }

    remote void function exportUsersToExcel() {
        var adminService = new model.Adminuser();
        return adminService.exportUsersToExcel();
    }

    remote void function exportProductsToExcel() {
        var adminService = new model.Adminuser();
        return adminService.exportProductsToExcel();
    }

    remote void function exportOrdersToExcel() {
        var adminService = new model.Adminuser();
        return adminService.exportOrdersToExcel();
    }
}