
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
    <script src="/Eshopper/public/assets/js/templates.js"></script>
    <script src="/Eshopper/public/assets/js/auth.js"></script>
    <script src="/Eshopper/public/assets/js/user.js"></script>
    <script src="/Eshopper/public/assets/js/index.js"></script>
</head>
<body>

<div class="container">
    <h2 class="text-center">Add Product</h2>
    <form id="addProductForm">
        <div class="form-group">
            <label for="productName">Product Name:</label>
            <input type="text" class="form-control" id="productName" name="productName" required>
        </div>
        <div class="form-group">
            <label for="category">Category:</label>
            <select class="form-control" id="category" name="category" required>
                <option value="watch">Watch</option>
                <option value="camera">Camera</option>
                <option value="drone">Drone</option>
                <option value="mobile">Mobile</option>
            </select>
        </div>        
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="number" class="form-control" id="price" name="price" step="0.01" required>
        </div>
        <div class="form-group">
            <label for="stockQuantity">Stock Quantity:</label>
            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" required>
        </div>
        <div class="form-group">
            <label for="productFile">Product Image:</label>
            <input type="file" class="form-control-file" id="productFile" name="productFile" accept="image/*" required>
        </div>
        
        <button type="submit" class="btn btn-primary" id="addProductDB">Add Product</button>
        <a href="adminDashboard.cfm" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

