<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
    <script src="./assets/js/templates.js"></script>
    <script src="./assets/js/auth.js"></script>
    <script src="./assets/js/user.js"></script>
    <script src="./assets/js/index.js"></script>
    <script src="./assets/js/cart.js"></script>

    <title>Admin Login</title>
</head>
<body>
    <div class="container mt-5">
        <div>
            <a href="/public/assets/templates/dashboard.hbs" class="logo" style="text-decoration: none; color:black;">
            <h1 class="text-center">e-Shopper</h1></a>
        </div>
        <h3 class="text-center">Admin Login</h3>
        <form id="loginForm" class="mt-4">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="button" class="btn btn-primary btn-block" name="submitAdminLogin" id="submitAdminLogin">Login</button>
        </form>
        <div class="text-center mt-3">
            <button class="btn btn-link" id="alreadyRegisterred">Back to User? Login.</button>
        </div>
    </div>
</body>
</html>
