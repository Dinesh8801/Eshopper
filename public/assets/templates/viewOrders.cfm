<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Orders</title>
    
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <!--- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> --->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" integrity="sha384-tViUnnbYAV00FLIhhi3v/dWt3Jxw4gZQcNoSCxCIFNJVCx7/D55/wXsrNIRANwdD" crossorigin="anonymous">
        
        <style>
    
            #salesContainer {
                background-color: #e7f1fb;  
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
    
            #salesContainer tbody tr {
                background-color: #ffffff; 
            }
    
            #salesContainer tbody tr:nth-child(even) {
                background-color: #d0e6fa; 
            }
    
            #salesContainer tbody tr:hover {
                background-color: #c1d8f9; 
            }
    
            #salesContainer thead {
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
        <h2 class="text-center">Orders List</h2>
        <button id="exportOrders" class="btn btn-primary mb-3">Export Sales</button>
        
        <!-- Sales DataTable -->
        <table class="table" id="salesContainer">
            <thead>
                <tr>
                    <th>Sale ID</th>
                    <th>Customer ID</th>
                    <th>Sale Date</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="salesTableBody">
                <!-- Sales data will be dynamically inserted here -->
            </tbody>
        </table>
        
    </div>
<!-- Edit Order Modal -->
<div class="modal fade" id="editOrderModal" tabindex="-1" aria-labelledby="editOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editOrderModalLabel">Edit Order</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="editOrderForm">
              <input type="hidden" id="saleId">
              <div class="form-group">
                  <label for="customerId">Customer ID</label>
                  <input type="text" id="customerId" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="saleDate">Sale Date</label>
                  <input type="text" id="saleDate" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="productId">Product ID</label>
                  <input type="number" id="productId" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="productName">Product Name</label>
                  <input type="text" id="productName" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="quantity">Quantity</label>
                  <input type="number" id="quantity" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="price">Price</label>
                  <input type="number" id="price" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="totalAmount">Total Amount</label>
                  <input type="number" id="totalAmount" class="form-control" readonly>
              </div>
              <div class="form-group">
                  <label for="status">Status</label>
                  <select id="status" class="form-control" required>
                      <option value="" disabled selected>Select status</option>
                      <option value="Packaging">Packaging</option>
                      <option value="Shipped">Shipped</option>
                      <option value="Out for delivery">Out for delivery</option>
                      <option value="Delivered">Delivered</option>
                  </select>
              </div>
              
              <button type="button" id="updateOrderButton" class="btn btn-primary">Update Order</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  

</body>
</html>
