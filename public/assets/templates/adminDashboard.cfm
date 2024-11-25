<cfquery name="GetSales" datasource="martDSN">
    SELECT p.ProductName, s.Price, s.SaleDate
    FROM Products p, Sales s
    WHERE p.ProductID = s.ProductID
</cfquery>

<cfquery name="GetCategory" datasource="martDSN">
    SELECT p.Category, s.ProductName 
    FROM Products p, Sales s 
    WHERE p.ProductID = s.ProductID 
</cfquery>

<cfquery name="GetUsers" datasource="martDSN">
    SELECT COUNT(UserID) AS userCount
    FROM martUsers 
</cfquery>

<cfquery name="GetSalesCount" datasource="martDSN">
    SELECT COUNT(SaleID) AS saleCount
    FROM sales 
</cfquery>

<cfquery name="GetProductsCount" datasource="martDSN">
    SELECT COUNT(ProductID) AS productCount
    FROM products 
</cfquery>

<cfquery name="GetSalesAmount" datasource="martDSN">
    SELECT SUM(TotalAmount) AS saleAmount
    FROM sales 
</cfquery>

<cfquery dbtype="query" name="productSales">
    SELECT ProductName, COUNT(ProductName) AS SumByProduct 
    FROM GetSales 
    GROUP BY ProductName
</cfquery>

<cfquery dbtype="query" name="categorySales">
    SELECT Category, COUNT(ProductName) AS SumByCategory 
    FROM GetCategory 
    GROUP BY Category
</cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Shopper Admin Dashboard</title>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="/Eshopper/public/assets/js/templates.js"></script>
    <script src="/Eshopper/public/assets/js/auth.js"></script>
    <script src="/Eshopper/public/assets/js/user.js"></script>
    <script src="/Eshopper/public/assets/js/index.js"></script>
    <script src="/Eshopper/public/assets/js/cart.js"></script>
    <script src="/Eshopper/public/assets/js/admin.js"></script>
</head>
<body>

    <cfinclude template="adminHeader.cfm">

    <div class="d-flex">
        <!-- Sidebar -->
        <nav class="d-flex bg-primary text-white sidebar" style="height: 92vh; width: 250px;">
            <div class="position-sticky">
                <h4 class="p-3">Admin Menu</h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#">
                            <i class="bi bi-house-door"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="viewUsers.cfm">
                            <i class="bi bi-person"></i> Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="viewProducts.cfm">
                            <i class="bi bi-box"></i> Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="viewCategories.cfm">
                            <i class="bi bi-tags"></i> Categories
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="viewOrders.cfm">
                            <i class="bi bi-gift"></i> Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="salesReports.cfm">
                            <i class="bi bi-bar-chart-line"></i> Reports
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="viewCoupons.cfm">
                            <i class="bi bi-ticket-detailed"></i> Coupons
                        </a>
                    </li>
                    <!--- <li class="nav-item">
                        <a class="nav-link text-white" id="logoutButton">
                            <i class="bi bi-box-arrow-right"></i> Logout
                        </a>
                    </li> --->
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <div class="container mt-5">
            <div class="row">
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-primary text-white mb-4">
                        <div class="card-body">Customers <i class="bi bi-people-fill"></i> <h1><cfoutput>#GetUsers.userCount#</cfoutput></h1> </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white" href="#" id="addUserButton">Add User</a>
                            <a class="small text-white" href="viewUsers.cfm">View Customers</a>
                            <div class="small text-white"><i class="bi bi-people-fill"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-secondary text-white mb-4">
                        <div class="card-body">Orders  <i class="bi bi-box-fill"></i> <h1><cfoutput>#GetSalesCount.saleCount#</cfoutput></h1></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="viewOrders.cfm">View Orders</a>
                            <div class="small text-white"><i class="bi bi-box-fill"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-info text-white mb-4">
                        <div class="card-body">Sales Revenue <i class="bi bi-currency-rupee"></i> <h1><cfoutput>#GetSalesAmount.saleAmount#</cfoutput></h1></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white stretched-link" href="salesReports.cfm">View Sales</a>
                            <div class="small text-white"><i class="bi bi-currency-rupee"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-dark text-white mb-4">
                        <div class="card-body">Products <i class="bi bi-camera2"></i> <h1><cfoutput>#GetProductsCount.productCount#</cfoutput></h1></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <a class="small text-white" href="#" id="addProductButton">Add Product</a>
                            <a class="small text-white" href="viewProducts.cfm">View Products</a>
                            <div class="small text-white"><i class="bi bi-camera2"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <!--- <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">Users</div>
                        <div class="card-body">
                            <p>Manage the registered users on your platform.</p>
                            <!--- <cfoutput>#GetUsers.userCount#</cfoutput> --->
                            <a class="btn btn-light" href="#" id="addUserButton">Add User</a>
                            <a class="btn btn-secondary" href="#" id="viewUsersButton">View Users</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card shadow">
                        <div class="card-header bg-success text-white">Products</div>
                        <div class="card-body">
                            <p>Manage the products available for sale.</p>
                            <a class="btn btn-light" href="#" id="addProductButton">Add Product</a>
                            <a class="btn btn-secondary" href="#" id="viewProductsButton">View Products</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card shadow">
                        <div class="card-header bg-warning text-dark">Categories</div>
                        <div class="card-body">
                            <p>Organize products into categories.</p>
                            <a class="btn btn-light" href="#" id="addCategoryButton">Add Category</a>
                            <a class="btn btn-secondary" href="#" id="viewCategoriesButton">View Categories</a>
                        </div>
                    </div>
                </div>
            </div> --->

            <div class="row justify-content-center">
                <div class="col-md-5">
                    <cfchart
                    title="Category Sales"
                        xAxisTitle="Category"
                        yAxisTitle="No of Orders"
                        font="Arial" 
                        gridlines=6 
                        showXGridlines="no" 
                        showYGridlines="no" 
                        showborder="no" 
                        show3d="yes"
                        chartWidth="480"
                        chartheight="400" >
                        
                        <cfchartseries
                            type="bar"
                            query="categorySales"
                            valuecolumn="SumByCategory"
                            itemcolumn="Category"
                            colorlist="##6666FF,##66FF66,##FF6666,##66CCCC"
                            seriesColor="##xxFF33CC" 
                            paintStyle="shade" >
                        </cfchartseries>
                        
                    </cfchart>
                </div>
    
                <div class="col-md-7">
                    <cfchart
                    title="Product Sales"
                        tipStyle="mousedown"
                        font="Times"
                        fontsize=14
                        fontBold="yes"
                        backgroundColor="white"
                        show3D="yes"
                        chartWidth="750"
                        chartheight="400" 
                        showLegend="no">
    
                        <cfchartseries
                            type="pie"
                            query="productSales"
                            valueColumn="SumByProduct"
                            itemColumn="ProductName"
                            colorlist="##6666FF,##66FF66,##FF6666,##66CCCC" />
                    </cfchart>
                </div>
            </div>
        </div>

        
    </div>
    <cfinclude template="adminFooter.cfm">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
