<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Users</title>
    
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <!--- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> --->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
        
        <style>
    
            #usersContainer {
                background-color: #e7f1fb;  
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
    
            #usersContainer tbody tr {
                background-color: #ffffff; 
            }
    
            #usersContainer tbody tr:nth-child(even) {
                background-color: #d0e6fa; 
            }
    
            #usersContainer tbody tr:hover {
                background-color: #c1d8f9; 
            }
    
            #usersContainer thead {
                background-color: #b3d7f5; 
                color: #495057; 
            }
    
            .dataTables_wrapper .dataTables_paginate {
                background-color: #ffffff;
                padding: 10px;
                border-radius: 8px;
            }
    
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                color: #495057;
                border: 1px solid #dee2e6;
            }
    
            .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                background-color: #c1d8f9; 
            }
        </style>
    
        <script src="/Eshopper/public/assets/js/admin.js"></script>
        <script src="/Eshopper/public/assets/js/index.js"></script>
    </head>
    
<body>
    <cfinclude template="adminHeader.cfm">
<div class="container mt-2">
    <a href="adminDashboard.cfm" class="btn btn-secondary">Back</a>
    <h2 class="text-center">Users List</h2>
    <div class="d-flex justify-content-between">
        <button id="exportUsers"  class="btn btn-primary mb-3">Export Users</button>
        <button id="addUserButton"  class="btn btn-primary mb-3">Add User</button>
    </div>
    <table class="table" id="usersContainer">
        <thead>
            <tr>
                <th>Username</th>
                <th>Password</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="userTableBody">
            <!-- Users will be injected here -->
        </tbody>
    </table>
    
</div>
<cfinclude template="adminFooter.cfm">
<!-- Modal for Editing User -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
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
                  <select class="form-control" id="userrole" name="userrole" required>
                      <option value="user">User</option>
                      <option value="admin">Admin</option>
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
              <button type="button" id="updateUserButton" class="btn btn-primary">Update User</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  

<!-- Modal for Confirming User Deletion -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="deleteUserModalLabel">Confirm Deletion</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          Are you sure you want to delete this user?
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-danger" id="confirmDeleteUserBtn">Delete</button>
        </div>
      </div>
    </div>
  </div>
  

</body>
</html>
