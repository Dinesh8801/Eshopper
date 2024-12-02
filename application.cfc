component {
	this.name = "e-Shopper";
	this.sessionManagement = true;
	this.setClientCookies = true;

	this.allowedActions = [
		"login",
		"logout",
		"register",
		"viewProducts",
		"getCategoriesForAjax",
		"getCartItems",
		"getProductsForAjax",
		"loginForAjax",
		"addToCart",
		"getCartItems"
	];

	function onApplicationStart() {
		try {
			application.isActive = true;
			return true;
		} catch (any e) {
			logError(e.message);
			return false;
		}
	}

	function onSessionStart() {
		session.isLoggedIn = false;
		session.cart = ArrayNew(1);
	}

	function onRequestStart() {
		if (not StructKeyExists(session, "cart")) {
			session.cart = ArrayNew(1);
		}

		if (not StructKeyExists(session, "isLoggedIn") or not session.isLoggedIn) {
			if (cgi.SCRIPT_NAME contains "adminDashboard.cfm" OR
				cgi.SCRIPT_NAME contains "adminHeader.cfm" OR
				cgi.SCRIPT_NAME contains "addUser.cfm" OR
				cgi.SCRIPT_NAME contains "addProduct.cfm" OR
				cgi.SCRIPT_NAME contains "addCategory.cfm" OR
				cgi.SCRIPT_NAME contains "editUser.cfm" OR
				cgi.SCRIPT_NAME contains "editCustomer.cfm" OR
				cgi.SCRIPT_NAME contains "editCategory.cfm" OR
				cgi.SCRIPT_NAME contains "editProduct.cfm" OR
				cgi.SCRIPT_NAME contains "editOrder.cfm" OR
				cgi.SCRIPT_NAME contains "viewUsers.cfm" OR
				cgi.SCRIPT_NAME contains "viewProducts.cfm" OR
				cgi.SCRIPT_NAME contains "viewCategories.cfm" OR
				cgi.SCRIPT_NAME contains "viewOrders.cfm" OR
				cgi.SCRIPT_NAME contains "salesReports.cfm" OR
				cgi.SCRIPT_NAME contains "header.cfm" OR
				cgi.SCRIPT_NAME contains "footer.cfm" OR
				cgi.SCRIPT_NAME contains "orderSuccess.cfm" OR
				cgi.SCRIPT_NAME contains "orders.cfm" OR
				cgi.SCRIPT_NAME contains "dashboard.cfm" OR
				cgi.SCRIPT_NAME contains "watch.cfm" OR
				cgi.SCRIPT_NAME contains "mobile.cfm" OR
				cgi.SCRIPT_NAME contains "drone.cfm" OR
				cgi.SCRIPT_NAME contains "camera.cfm" OR
				cgi.SCRIPT_NAME contains "profile.cfm" OR  
				cgi.SCRIPT_NAME contains "cart.cfm") {
				cflocation(url="/Eshopper/public/", addToken="false");
				abort;
			}
			}
			else if (session.isLoggedIn && session.userrole == "user") {
				if (cgi.SCRIPT_NAME contains "adminDashboard.cfm" OR
				cgi.SCRIPT_NAME contains "adminHeader.cfm" OR
				cgi.SCRIPT_NAME contains "addUser.cfm" OR
				cgi.SCRIPT_NAME contains "addProduct.cfm" OR
				cgi.SCRIPT_NAME contains "addCategory.cfm" OR
				cgi.SCRIPT_NAME contains "editUser.cfm" OR
				cgi.SCRIPT_NAME contains "editCategory.cfm" OR
				cgi.SCRIPT_NAME contains "editProduct.cfm" OR
				cgi.SCRIPT_NAME contains "editOrder.cfm" OR
				cgi.SCRIPT_NAME contains "viewUsers.cfm" OR
				cgi.SCRIPT_NAME contains "viewProducts.cfm" OR
				cgi.SCRIPT_NAME contains "viewCategories.cfm" OR
				cgi.SCRIPT_NAME contains "viewOrders.cfm" OR
				cgi.SCRIPT_NAME contains "salesReports.cfm") {
					cflocation(url="/Eshopper/public/", addToken="false");
				}
				
		}

		
	}

	function checkAccess(required string action) {
		if (not arrayContains(application.allowedActions, action)) {
			throw(new Exception("Unauthorized access", 403));
		}
	}
}
