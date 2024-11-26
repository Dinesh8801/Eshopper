<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Online Mart</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">E-Shopper</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
				<a class="nav-link active" aria-current="page" href="#">Home</a>
				</li>
				<li class="nav-item">
				<a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">My Account</a>
				</li>
				<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					Categories
				</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="./dashboard.hbs/#camaras">Camaras</a></li>
					<li><a class="dropdown-item" href="#mobiles">Mobiles</a></li>
					<li><a class="dropdown-item" href="#drones">Drones</a></li>
					<li><a class="dropdown-item" href="#watches">Watches</a></li>
				</ul>

				</li>
				<li class="nav-item">
				<a class="nav-link" href="cart.hbs"><i class="bi bi-cart-plus-fill"></i> Cart</a>
				</li>
			</ul>
			<form class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
			</div>
		</div>
	</nav>

	<nav aria-label="breadcrumb" style="background-color: #eee">
			<ol class="breadcrumb p-3">
				<li class="breadcrumb-item"><a href="#">Home</a></li>
				<li class="breadcrumb-item"><a href="#">Camara</a></li>
				<li class="breadcrumb-item active" aria-current="page">MX-5</li>
			</ol>   
	</nav>


	<div class="container mb-5">
		<div class="row d-flex flex-row">
			<div class="col-md-5 product-image">
					<img class="img-fluid" src="../../images/product-1-square.jpg" alt="">
			</div>

			<div class="col-md-2 product-small d-flex flex-md-column justify-content-center order-md-first" >
				<img class="img-fluid" src="../../images/product-1-square.jpg" style="max-width: 10rem; padding: 1rem;" alt="">
				<img class="img-fluid" src="../../images/product-1-square.jpg" style="max-width: 10rem; padding: 1rem;" alt="">
				<img class="img-fluid" src="../../images/product-1-square.jpg" style="max-width: 10rem; padding: 1rem;" alt="">
			</div>
			
			<div class="col-md-5">
				<h6>Brand</h6>
				<h2>Product Name</h2>
				<h5>Price $</h5>
				<div>Color</div>
				<button class="btn btn-primary"><i class="bi bi-cart-plus-fill"></i> Add To Cart</button>
				<div>Details
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header">
							<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								Accordion Item #1
							</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
							</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
								Accordion Item #2
							</button>
							</h2>
							<div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
							</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
								Accordion Item #3
							</button>
							</h2>
							<div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>


	<div class="footer mt-auto bg-dark text-light">
		<div class="container py-3">
			<div class="row d-flex">
				<div class="col">
					<h5>Categories</h5>
					<ul>
						<li>Watches</li>
						<li>Mobiles</li>
						<li>Tablets</li>
						<li>Headphones</li>
						<li>Drones</li>
					</ul>
				</div>
				<div class="col">
					<h5>Useful Links</h5>
					<ul>
						<li>Terms</li>
						<li>Privacy</li>
						<li>About Us</li>
						<li>Mission</li>
					</ul>
				</div>
				<div class="col">
					<h5>Get Updates</h5>
					<div class="d-flex">
						<input type="text" class="form-control">
						<button class="btn btn-primary">Subscribe</button>
					</div>
				</div>
			</div>

		</div>
		
	</div>
	
</body>
</html>