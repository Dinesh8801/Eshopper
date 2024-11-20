<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="addUserForm">
            <div class="form-group">
              <label for="username">Username:</label>
              <input type="text" class="form-control" id="addusername" name="username" required>
            </div>
            <div class="form-group">
              <label for="password">Password:</label>
              <input type="password" class="form-control" id="addpassword" name="password" required>
            </div>
            <div class="form-group">
              <label for="email">Email:</label>
              <input type="email" class="form-control" id="addemail" name="email" required>
            </div>
            <div class="form-group">
              <label for="role">Role:</label>
              <select class="form-control" id="addrole" name="role" required>
                <option value="admin">Admin</option>
                <option value="user">User</option>
              </select>
            </div>
            <button type="button" class="btn btn-primary" id="addUserDB">Add User</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="addProductForm">
            <div class="form-group">
              <label for="productName">Product Name:</label>
              <input type="text" class="form-control" id="addproductName" name="productName" required>
            </div>
            <div class="form-group">
              <label for="category">Category:</label>
              <select class="form-control" id="addcategory" name="category" required>
                <option value="watch">Watch</option>
                <option value="camera">Camera</option>
                <option value="drone">Drone</option>
                <option value="mobile">Mobile</option>
              </select>
            </div>        
            <div class="form-group">
              <label for="price">Price:</label>
              <input type="number" class="form-control" id="addprice" name="price" step="0.01" required>
            </div>
            <div class="form-group">
              <label for="stockQuantity">Stock Quantity:</label>
              <input type="number" class="form-control" id="addstockQuantity" name="stockQuantity" required>
            </div>
            <div class="form-group">
              <label for="productFile">Product Image:</label>
              <input type="file" class="form-control-file" id="addproductFile" name="productFile" accept="image/*" required>
            </div>
            
            <button type="button" class="btn btn-primary" id="addProductDB">Add Product</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="addCategoryForm">
            <div class="form-group">
              <label for="categoryName">Category Name:</label>
              <input type="text" class="form-control" id="addcategoryName" name="categoryName" required>
            </div>
            <button type="button" class="btn btn-primary" id="addCategoryDB">Add Category</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  