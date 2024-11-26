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
<body class="d-flex flex-column" style="min-height: 100vh;">
	<cfinclude template="header.cfm">
	<div class="container my-5">
		
		<div>
				<h1 class="text-center">e-Shopper</h1>
		</div>
		<div class="d-flex justify-content-center">
			
			<div class="login-box m-auto mt-5 col-4 text-center" style="background-color: #eee; border-radius: 20px; padding: 2rem;">
				<h3 class="text-center">Order Placed Successful</h3>
				<i class="bi bi-check-circle-fill text-success" style="font-size: 10rem;"></i>
				<h6>We will deliver your order in 2-3 days.</h6>
				<a href="./dashboard.cfm">Continue Shopping</a>
			</div>
		</div>
		
	</div>

	<cfinclude template="footer.cfm">
</body>
</html>