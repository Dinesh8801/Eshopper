<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
    <script src="../../assets/js/cart.js"></script>

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-header" style="position: fixed; top: 0; left: 0; width: 100%; z-index: 1030;">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.cfm">E-Shopper</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="dashboard.cfm">Home</a>
                </li>
                <!--- <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categories
                    </a>
                    <ul class="dropdown-menu" id="dropdownHeader">
                        <!-- Categories will be injected here -->
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.cfm" id="cartNavButton" ><i class="bi bi-cart-plus-fill"></i> Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="ordersNavButton" href="orders.cfm">My Orders</a>
                </li> --->
            </ul>
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" id="searchBar" placeholder="Search" aria-label="Search">
                <button class="btn btn-success" type="submit" id="searchButton"><i class="bi bi-search"></i></button>
            </form>
            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="cart.cfm" id="cartNavButton" ><i class="bi bi-cart-plus-fill"></i> Cart</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="myaccount" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        My Account
                    </a>
                    <ul class="dropdown-menu">
                        <a class="dropdown-item" href="profile.cfm" id="navProfile">My Profile</a>
                        <a class="dropdown-item" href="orders.cfm" id="ordersNavButton">My Orders</a>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="btn btn-danger dropdown-item" href="login.cfm" id="logoutButton">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

</body>
</html>
