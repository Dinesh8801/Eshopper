<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Categories</title>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!--- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> --->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
    
    <style>

        #categoriesContainer {
            background-color: #e7f1fb;  
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        #categoriesContainer tbody tr {
            background-color: #ffffff; 
        }

        #categoriesContainer tbody tr:nth-child(even) {
            background-color: #d0e6fa; 
        }

        #categoriesContainer tbody tr:hover {
            background-color: #c1d8f9; 
        }

        #categoriesContainer thead {
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
        <h2 class="text-center">Categories List</h2>
        <button id="addCategoryButton" class="btn btn-primary mb-3 ml-auto d-block">Add Category</button>
    
        <table class="table " id="categoriesContainer">
            <thead>
                <tr>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="categoriesTableBody">
                
            </tbody>
        </table>
    </div>
    <cfinclude template="adminFooter.cfm">
    <!-- Edit Category Modal -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="editCategoryForm">
              <input type="hidden" id="categoryId">
              <div class="form-group">
                  <label for="categoryName">Category Name</label>
                  <input type="text" id="categoryName" class="form-control" required>
              </div>
              <button type="button" id="updateCategoryButton" class="btn btn-primary">Update Category</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  

<!-- Modal for Confirming Category Deletion -->
<div class="modal fade" id="deleteCategoryModal" tabindex="-1" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="deleteCategoryModalLabel">Confirm Deletion</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          Are you sure you want to delete this category?
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-danger" id="confirmDeleteCategoryBtn">Delete</button>
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>
