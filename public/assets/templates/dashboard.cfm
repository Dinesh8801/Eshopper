<cfset session.page = "dashboard">

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>E-Shopper</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


</head>
<body style="padding-top: 56px;">
		<cfinclude template="header.cfm">

	<!---end of nav--->

	<div id="carouselExampleDark" class="carousel carousel-dark slide mb-5" data-bs-ride="carousel">
		<ol class="carousel-indicators">
			<li data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active"></li>
			<li data-bs-target="#carouselExampleDark" data-bs-slide-to="1"></li>
			<li data-bs-target="#carouselExampleDark" data-bs-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active" data-bs-interval="3000">
			<img src="../../images/product-2-slider.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item" data-bs-interval="3000">
			<img src="../../images/product-3-slider.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item" data-bs-interval="3000">
			<img src="../../images/product-6-slider.jpg" class="d-block w-100" alt="...">   
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>

	<!-- end of carousel -->

	<!--- <div class="container mb-5">
		<div id="productsList" class="row">
		</div>
	</div> --->

	<div class="container mb-5">
		<div class="row">
			<div class="col-2 mt-5">
				<div class="d-flex mb-5" role="search">
					<input class="form-control me-2" type="search" id="searchBar" placeholder="Search" aria-label="Search">
					<button class="btn btn-success" type="submit" id="searchButton"><i class="bi bi-search"></i></button>
				</div>
				<h5>Filters</h5>
				<div id="categoryFilters">
					<!-- Category checkboxes will be dynamically populated here -->
				</div>
				<button id="applyFilters" class="btn btn-primary mt-3">Apply Filters</button>
			</div>

			<div class="col-10">
				<div id="productsList" class="row">
					<!-- Products will be displayed here dynamically -->
				</div>
			</div>
		</div>
	</div>
	<cfinclude template="footer.cfm">
	

	<!-- end of footer-->
	
	<script src="../../assets/js/index.js"></script>
	<script src="../../assets/js/cart.js"></script>
	<script src="../../assets/js/orders.js"></script>
</body>
</html>