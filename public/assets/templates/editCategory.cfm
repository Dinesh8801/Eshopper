<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Edit Category</title>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="/Eshopper/public/assets/js/templates.js"></script>
	<script src="/Eshopper/public/assets/js/auth.js"></script>
	<script src="/Eshopper/public/assets/js/user.js"></script>
	<script src="/Eshopper/public/assets/js/index.js"></script>
	<script src="/Eshopper/public/assets/js/admin.js"></script>
	<script src="/Eshopper/public/assets/js/operations.js"></script>
</head>
<body>

	<div class="container">
		<h1>Edit Category</h1>
		<form id="editCategoryForm">
			<cfoutput><input type="hidden" id="categoryId" value="#CategoryId#"></cfoutput>
			<div class="form-group">
				<label for="categoryName">Category Name</label>
				<input type="text" id="categoryName" class="form-control" required>
			</div>
			<button type="button" id="updateCategoryButton" class="btn btn-primary">Update Category</button>
			<a href="viewCategories.cfm" class="btn btn-secondary">Back</a>
		</form>
	</div>
</body>
</html>
