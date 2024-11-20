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
    <script src="../../assets/js/user.js"></script>
    <script src="../../assets/js/admin.js"></script>
</head>
<body class="d-flex flex-column min-vh-100" style="height: 100%; padding-top: 56px;">
    <cfinclude template="header.cfm">
    <div class="container">
        <h2>Edit User</h2>
        <form id="editUserForm">
            <input type="hidden" id="userId" value="">
            <div class="form-group">
                <label for="firstname">First Name</label>
                <input type="text" id="firstname" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="lastname">Last Name</label>
                <input type="text" id="lastname" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="role">Role:</label>
                <select class="form-control" id="userrole" name="userrole" required readonly>
                    <option value="user">User</option>
                </select>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="country">Country</label>
                <input type="text" id="country" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" id="state" class="form-control" value="">
            </div>
            <div class="form-group">
                <label for="zip">Zip Code</label>
                <input type="text" id="zip" class="form-control" value="">
            </div>
            <div class="mb-2">
                <button type="button" id="updateUserButton" class="btn btn-primary">Update Details</button>
                <a href="profile.cfm" class="btn btn-secondary">Back</a>
            </div>
        </form>
    </div>

    <cfinclude template="footer.cfm">
</body>
</html>
