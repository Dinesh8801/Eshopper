component {
	remote string function registerUser() returnformat="JSON" {
        var userService = new model.User();
        return userService.registerUser();
    }

    remote string function loginForAjax(string username, string password) returnformat="JSON" {
        var userService = new model.User();
        return userService.loginForAjax(username=arguments.username, password=arguments.password);
    }

    remote string function sendPasswordResetEmail(string email) returnformat="JSON" {
        var userService = new model.User();
        return userService.sendPasswordResetEmail(email=arguments.email);
    }

    remote struct function logoutUser() returnformat="JSON"{
        var userService = new model.User();
        return userService.logoutUser();
    }

    remote struct function getUserBySession() returnformat="JSON" {
        var userService = new model.User();
        return userService.getUserBySession();
    }

    remote struct function updatePasswordReset(string username, string newPassword) returnformat="JSON" {
        var userService = new model.User();
        return userService.updatePasswordReset(username=arguments.username, newPassword=arguments.newPassword);
    }

    remote void function generateInvoice(string orderId) {
        var userService = new model.User();
        return userService.generateInvoice(orderId=arguments.orderId);
    }
}