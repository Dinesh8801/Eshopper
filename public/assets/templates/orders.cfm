<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>List of Orders</title>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js" defer></script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        
        <style>
            table.dataTable tbody tr.myeven{
            background-color:#f2dede !important;
            }
            table.dataTable tbody tr.myodd{
                background-color:#bce8f1 !important;
            }
        </style>
        
        <script src="../../assets/js/orders.js"></script>
        <script src="../../assets/js/index.js"></script>
    </head>
    
    
<body class="d-flex flex-column min-vh-100" style="height: 100%; padding-top: 56px;">
    <cfinclude template="header.cfm">
    <div class="container mt-2 flex-fill" style="flex: 1 0 auto;">
        <div class="d-flex justify-content-center row">
            <div class="col-md-10">
                <div class="form-group">
                    <label for="monthsDropdown">Select Time Frame:</label>
                    <select id="monthsDropdown" class="form-control mb-3">
                        <option value="1">Last 1 Month</option>
                        <option value="3">Last 3 Months</option>
                        <option value="6">Last 6 Months</option>
                        <option value="12">Last 12 Months</option>
                    </select>
                    <button id="filterButton" class="btn btn-secondary">Filter Orders</button>
                </div>
                <div class="rounded">
                    <div class="table-responsive" id="ordersContainer"></div>
                </div>
            </div>
        </div>
    </div>
    <cfinclude template="footer.cfm">
</body>
</html>
