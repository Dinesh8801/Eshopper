<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="adminDashboard.cfm">E-Shopper Admin Dashboard</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
        <ul class="navbar-nav ml-auto">
            <!-- Users Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="usersDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Users
                </a>
                <div class="dropdown-menu" aria-labelledby="usersDropdown">
                    <a class="dropdown-item" href="#" id="addUserButton">Add User</a>
                    <a class="dropdown-item" href="#" id="viewUsersButton">View Users</a>
                </div> 
            </li>   
        </ul>
        <ul class="navbar-nav mb-2 mb-lg-0">
            <!-- Products Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="productsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Products
                </a>
                <div class="dropdown-menu" aria-labelledby="productsDropdown">
                    <a class="dropdown-item" href="#" id="addProductButton">Add Product</a>
                    <a class="dropdown-item" href="#" id="viewProductsButton">View Products</a>
                </div>
            </li>

            <!-- Categories Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="categoriesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Categories
                </a>
                <div class="dropdown-menu" aria-labelledby="categoriesDropdown">
                    <a class="dropdown-item" href="#" id="addCategoryButton">Add Category</a>
                    <a class="dropdown-item" href="#" id="viewCategoriesButton">View Categories</a>
                </div>
            </li>

            <!-- Orders -->
            <li class="nav-item">
                <a class="nav-link" href="#" id="viewOrdersButton">View Orders</a>
            </li>

            <!-- Sales Reports -->
            <li class="nav-item">
                <a class="nav-link" href="#" id="viewSalesReportButton">View Reports</a>
            </li>

            <li class="nav-item">
                <a class="btn btn-danger ml-3" id="logoutButton">Logout</a>
            </li>
        </ul>
    </div>
</nav>


  