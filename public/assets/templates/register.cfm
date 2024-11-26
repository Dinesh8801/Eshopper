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

		<title>Registration</title>
</head>
<body>
		<div class="container mt-5">
				<div>
						<a href="/public/assets/templates/dashboard.cfm" class="logo" style="text-decoration: none; color:black;">
						<h1 class="text-center">e-Shopper</h1></a>
				</div>
				<h3 class="text-center">Register</h3>
				<form id="registrationForm" class="row mt-4">
						<div class="form-group col-sm-6">
								<label for="firstName" class="form-label">First name</label>
								<input type="text" class="form-control" id="firstName" placeholder="" value="" required>
								<div class="invalid-feedback">
									Valid first name is required.
								</div>
							</div>
	
							<div class="form-group col-sm-6">
								<label for="lastName" class="form-label">Last name</label>
								<input type="text" class="form-control" id="lastName" placeholder="" value="" required>
								<div class="invalid-feedback">
									Valid last name is required.
								</div>
							</div>
							<div class="form-group col-12">
								<label for="username" class="form-label">Username</label>
								<div class="input-group has-validation">
									<span class="input-group-text">@</span>
									<input type="text" class="form-control" id="username" placeholder="Username" required>
								<div class="invalid-feedback">
										Your username is required.
									</div>
								</div>
							</div>
								<div class="form-group">
										<label for="password">Password:</label>
										<input type="password" class="form-control" id="password" name="password" required>
								</div>
						<div class="form-group">
								<label for="email">Email:</label>
								<input type="email" class="form-control" id="email" name="email" required>
						</div>
						<div class="form-group col-12">
								<label for="address" class="form-label">Address</label>
								<input type="text" class="form-control" id="address" placeholder="Flat No: x, Apartment " required>
								<div class="invalid-feedback">
									Please enter your shipping address.
								</div>
							</div>
	
							<div class="form-group col-md-5">
								<label for="country" class="form-label">Country</label>
								<select class="form-select" id="country" required>
									<option value="">Choose...</option>
									<option>India</option>
								</select>
								<div class="invalid-feedback">
									Please select a valid country.
								</div>
							</div>
	
							<div class="form-group col-md-4">
								<label for="state" class="form-label">State</label>
								<select class="form-select" id="state" required>
									<option value="">Choose...</option>
									<option>Telanagana</option>
									<option>Andra Pradesh</option>
									<option>Karnataka</option>
								</select>
								<div class="invalid-feedback">
									Please provide a valid state.
								</div>
							</div>
	
							<div class="form-group col-md-3">
								<label for="zip" class="form-label">Zip</label>
								<input type="text" class="form-control" id="zip" placeholder="" required>
								<div class="invalid-feedback">
									Zip code required.
								</div>
							</div>
						<button type="button" class="btn btn-primary btn-block" id="registersubmitbutton">Register</button>
				</form>
				<div class="text-center mt-3">
						<button class="btn btn-link" id="alreadyRegisterred">Already registered? Login.</button>
				</div>
		</div>
</body>
</html>
