<!DOCTYPE html>
<html lang="en">
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>User Profile</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

		<script src="../../assets/js/index.js"></script>
</head>
<body class="d-flex flex-column min-vh-100" style="height: 100%; padding-top: 56px;">
		<cfinclude template="header.cfm">
		<div class="container">
				<h2>User Profile</h2>
						<div class="card mb-4" style="background-color: #eee;">
								<div class="card-body">
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">User ID:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="userId"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">FirstName:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="firstname"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">LastName:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="lastname"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">Username:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="username"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">Email:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="email"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">Address:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="address"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">Country:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="country"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">State:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="state"></span></p>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="col-sm-3">
											<p class="mb-0">Zip Code:</p>
										</div>
										<div class="col-sm-9">
											<p class="text-muted mb-0"><span id="zip"></span></p>
										</div>
									</div>
									<hr>
									<div class="d-flex justify-content-between">
										<button id="editCustomerDetails"  class="btn btn-warning">Edit</button>
										<a href="dashboard.cfm" class="btn btn-primary">Back to Home</a>
								</div>
						</div>
						
						
				</div>
		</div>

<cfinclude template="footer.cfm">
</body>
</html>
