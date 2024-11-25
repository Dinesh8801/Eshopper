$(document).ready(function() {
    if ($('#alertContainer').length === 0) {
        $('body').append('<div id="alertContainer" style="position: fixed; top: 60px; right: 20px; z-index: 1050;"></div>');
    }

    function showAlert(type, message) {
        const alertHtml = `
            <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        `;
        
        $('#alertContainer').append(alertHtml);
        
        setTimeout(() => {
            $('.alert').alert('close');
        }, 5000);
    }

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getUsersForAdmin',
        type: 'GET',
        dataType: 'json',
        
        success: function(response) {
            const users = response;
            const $tableBody = $('#userTableBody');
            $tableBody.empty();

            $.each(users, function(userId, user) {
                const row = `
                    <tr>
                        <td>${user.USERNAME}</td>
                        <td>${user.PASSWORD}</td>
                        <td>${user.EMAIL}</td>
                        <td>
                            <button class="btn btn-warning btn-sm editUser" data-user-id="${userId}">Edit</button>
                            <button class="btn btn-danger btn-sm deleteUser" data-user-id="${userId}">Delete</button>
                        </td>
                    </tr>
                `;
                $tableBody.append(row);
            });
            
            if ($.fn.DataTable.isDataTable('#usersContainer')) {
                $('#usersContainer').DataTable().destroy();
            }

            $('#usersContainer').DataTable({
                "pageLength": 10
            });
        },
        error: function(xhr, status, error) {
            console.error("Error fetching users:", error);
            alert("An error occurred while fetching users. Please try again.");
        }
    });

    // Handle the Edit Button Click
$(document).on('click', '.editUser', function() {
    const userId = $(this).data('user-id');
    console.log('User ID:', userId);

    if (!isNaN(userId) && userId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getUserById&userId=' + userId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('User Response:', response);
                if (response && response.userId) {
                    // Populate the modal with user data
                    $('#userId').val(response.userId);
                    $('#firstname').val(response.firstname);
                    $('#lastname').val(response.lastname);
                    $('#username').val(response.username);
                    $('#email').val(response.email);
                    $('#password').val(response.password);
                    $('#userrole').val(response.userrole);
                    $('#address').val(response.address);
                    $('#country').val(response.country);
                    $('#state').val(response.state);
                    $('#zip').val(response.zip);

                    // Show the modal
                    $('#editUserModal').modal('show');
                } else {
                    console.error('Invalid user response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('User AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid user ID');
    }
});


    $(document).on('click', '.deleteUser', function() {
        const userId = $(this).data('user-id');
        const userRow = $(this).closest('tr'); 
    
        $('#deleteUserModal').modal('show');
    
        $('#confirmDeleteUserBtn').off('click').on('click', function() {
            $.ajax({
                url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=deleteUser',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ userId: userId }),
                success: function(response) {
                    console.log("from delete user", response);
                    const result = response;
                    if (result.success) {
                        showAlert('success', result.MESSAGE);
    
                        userRow.remove();
                        
                        $('#deleteUserModal').modal('hide');
                        window.location.href = 'viewUsers.cfm';
                        setTimeout(function() {
                            window.location.href = 'viewUsers.cfm'; 
                        }, 500); 
                    } else {
                        showAlert('danger', result.MESSAGE);
                        $('#deleteUserModal').modal('hide');
                        window.location.href = 'viewUsers.cfm';
                        //window.location.href = 'viewUsers.cfm';
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error deleting user:", error);
                    showAlert('danger', "An error occurred while deleting the user.");
                }
            });
        });
    
        $('#deleteUserModal').on('hidden.bs.modal', function () {
            $('#confirmDeleteUserBtn').off('click');
        });
    });
    
    

    

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getProductsForAdmin',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log("Response received For Products:", response);
            const products = response;
            const $tableBody = $('#productTableBody');
            $tableBody.empty();

            $.each(products, function(productId, product) {
                const row = `
                    <tr>
                        <td>${product.PRODUCTNAME}</td>
                        <td>${product.CATEGORY}</td>
                        <td>${product.PRICE}</td>
                        <td>${product.STOCKQUANTITY}</td>
                        <td>
                            <button class="btn btn-warning btn-sm editProduct" data-product-id="${productId}">Edit</button>
                            <button class="btn btn-danger btn-sm deleteProduct" data-product-id="${productId}">Delete</button>
                        </td>
                    </tr>
                `;
                $tableBody.append(row);
            });
            
            if ($.fn.DataTable.isDataTable('#productsContainer')) {
                $('#productsContainer').DataTable().destroy();
            }

            $('#productsContainer').DataTable({
                "pageLength": 10
            });
        },
        error: function(xhr, status, error) {
            console.error("Error fetching products:", error);
            alert("An error occurred while fetching products. Please try again.");
        }
    });

    
$(document).on('click', '.editProduct', function() {
    const productId = $(this).data('product-id');
    console.log('Product ID:', productId);

    if (!isNaN(productId) && productId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getProductById&productId=' + productId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('Product Response:', response);
                if (response && response.productId) {
                    
                    $('#productId').val(response.productId);
                    $('#category').val(response.category);
                    $('#productName').val(response.productName);
                    $('#price').val(response.price);
                    $('#stockQuantity').val(response.stockQuantity);
                    $('#productPath').val(response.productPath);

                    
                    $('#editProductModal').modal('show');
                } else {
                    console.error('Invalid product response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('Product AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid product ID');
    }
});


    $(document).on('click', '.deleteProduct', function() {
        const productId = $(this).data('product-id');
        const row = $(this).closest('tr');  
    
        $('#deleteProductModal').modal('show');
    

        $('#confirmDeleteProductBtn').off('click').on('click', function() {
            $.ajax({
                url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=deleteProduct',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ productId: productId }),
                success: function(response) {
                    console.log("from delete product", response);
                    if (response.SUCCESS) {
                        showAlert('success', response.MESSAGE);
                        window.location.href = 'viewProducts.cfm';
            
                        row.remove();
    
                        $('#deleteProductModal').modal('hide');
    
                
                        setTimeout(function() {
                            window.location.href = 'viewProducts.cfm';  
                        }, 500);  
                    } else {
                        showAlert('danger', response.MESSAGE);
                        window.location.href = 'viewProducts.cfm';
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error deleting product:", error);
                    showAlert('danger', "An error occurred while deleting the product. Please try again.");
                }
            });
        });
    
        
        $('#deleteProductModal').on('hidden.bs.modal', function () {
            $('#confirmDeleteProductBtn').off('click'); 
        });
    });
    
    

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getOrdersForAdmin',
        dataType: 'json',
        success: function(response) {
            const $tableBody = $('#salesTableBody');
            $tableBody.empty();
    
            const salesIds = Object.keys(response);
            salesIds.forEach(function(saleId) {
                const sale = response[saleId];
                const row = `
                    <tr>
                        <td>${saleId}</td>
                        <td>${sale.CUSTOMERID || ''}</td>
                        <td>${moment(sale.SALEDATE).format('YYYY-MM-DD') || ''}</td>
                        <td>${sale.PRODUCTID || ''}</td>
                        <td>${sale.PRODUCTNAME || ''}</td>
                        <td>${sale.QUANTITY || ''}</td>
                        <td>${sale.PRICE || ''}</td>
                        <td>${sale.TOTALAMOUNT || ''}</td>
                        <td>${sale.STATUS || ''}</td>
                        <td>
                            <button class="btn btn-warning btn-sm editOrder" data-sale-id="${saleId}">Edit</button>
                        </td>
                    </tr>
                `;
                $tableBody.append(row);
            });
    
            if ($.fn.DataTable.isDataTable('#salesContainer')) {
                $('#salesContainer').DataTable().destroy();
            }
    
            $('#salesContainer').DataTable({
                "pageLength": 10,
                "order": [[2, 'desc']] 
            });
        },
        error: function() {
            console.error("Failed to fetch sales data");
        }
    });

   
$(document).on('click', '.editOrder', function() {
    const saleId = $(this).data('sale-id');
    console.log('Sale ID:', saleId);

    if (!isNaN(saleId) && saleId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getOrderById&saleId=' + saleId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('Order Response:', response);
                if (response && response.SaleID) {
                    
                    $('#saleId').val(response.SaleID);
                    $('#customerId').val(response.CustomerID);
                    $('#saleDate').val(response.SaleDate);
                    $('#productId').val(response.ProductID);
                    $('#productName').val(response.ProductName);
                    $('#quantity').val(response.Quantity);
                    $('#price').val(response.Price);
                    $('#totalAmount').val(response.TotalAmount);
                    $('#status').val(response.Status);

                    
                    $('#editOrderModal').modal('show');
                } else {
                    console.error('Invalid order response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('Order AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid order ID');
    }
});

    

$.ajax({
    url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getCategoriesForAdmin',
    type: 'GET',
    dataType: 'json',
    success: function(response) {
        console.log("Response received For Categories:", response);
        const categories = response;
        const $tableBody = $('#categoriesTableBody');
        $tableBody.empty(); 
        $.each(categories, function(categoryId, category) {
            const row = `
                <tr>
                    <td>${category.CATEGORYNAME}</td>
                    <td>
                        <button class="btn btn-warning btn-sm editCategory" data-category-id="${categoryId}">Edit</button>
                        <button class="btn btn-danger btn-sm deleteCategory" data-category-id="${categoryId}">Delete</button>
                    </td>
                </tr>
            `;
            $tableBody.append(row);
        });

        if ($.fn.DataTable.isDataTable('#categoriesContainer')) {
            $('#categoriesContainer').DataTable().destroy();
        }

        $('#categoriesContainer').DataTable({
            "pageLength": 10
        });
    },
    error: function(xhr, status, error) {
        console.error("Error fetching categories:", error);
        alert("An error occurred while fetching categories. Please try again.");
    }
});

$(document).on('click', '.editCategory', function() {
    const categoryId = $(this).data('category-id');
    console.log('Category ID:', categoryId);

    if (!isNaN(categoryId) && categoryId) {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getCategoryById&categoryId=' + categoryId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('Category Response:', response);
                if (response && response.categoryId) {
                 
                    $('#categoryId').val(response.categoryId);
                    $('#categoryName').val(response.categoryName);

                 
                    $('#editCategoryModal').modal('show');
                } else {
                    console.error('Invalid category response format:', response);
                }
            },
            error: function(xhr, status, error) {
                console.error('Category AJAX Error:', error);
            }
        });
    } else {
        console.error('Invalid category ID');
    }
});



    $(document).on('click', '.deleteCategory', function() {
        const categoryId = $(this).data('category-id');
    
        
        $('#deleteCategoryModal').modal('show');
    
        
        $('#confirmDeleteCategoryBtn').off('click').on('click', function() {
            
            $.ajax({
                url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=deleteCategory',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ categoryId: categoryId }),
                dataType: 'json',
                success: function(response) {
                    console.log("from categories delete", response);
                    if (response.success) {
                        showAlert('success', response.MESSAGE);
                        window.location.href = 'viewCategories.cfm';  
                    } else {
                        showAlert('danger', response.MESSAGE);
                        window.location.href = 'viewCategories.cfm';
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error deleting category:", error);
                    showAlert('danger', "An error occurred while deleting the category.");
                }
            });
    
           
            $('#deleteCategoryModal').modal('hide');
        });
    
        
        $('#deleteCategoryModal').on('hidden.bs.modal', function () {
            $('#confirmDeleteCategoryBtn').off('click');
        });
    });
    
    

    $(document).on('click', '#updateUserButton', function() {
        var userId = parseInt($('#userId').val());
        var firstname = $("#firstname").val();
        var lastname = $("#lastname").val();
        var username = $("#username").val();
        var address = $("#address").val();
        var email = $("#email").val();
        var password = $("#password").val();
        var userrole = $("#userrole").val();
        var country = $("#country").val(); 
        var state = $("#state").val(); 
        var zip = $("#zip").val(); 
        if(!firstname) {
            showAlert('danger', 'Please enter first name');
            return;
        }
        if(!lastname) {
            showAlert('danger', 'Please enter last name');
            return;
        }
        if(!username) {
            showAlert('danger', 'Please enter user name');
            return;
        }
        if(!password) {
            showAlert('danger', 'Please enter password');
            return;
        }
        if(!email) {
            showAlert('danger', 'Please enter email');
            return;
        }
        if(!zip) {
            showAlert('danger', 'Please enter zip');
            return;
        }
        
    
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=updateUser',
            type: 'POST',
            data: {
                userId: userId,
                firstname: firstname,
                lastname: lastname,
                username: username,
                address: address,
                email: email,
                password: password,
                userrole: userrole,
                country: country,
                state: state,
                zip: zip

            },
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('success',response.MESSAGE);
                    //window.location.href = 'viewUsers.cfm';
                } else {
                    showAlert('danger', response.MESSAGE);
                    //window.location.href = 'viewUsers.cfm';
                }
            },
            error: function(xhr, status, error) {             
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    });

    $(document).on('click', '#updateProductButton', function() {

        // if(!$("#category").val()) {
        //     showAlert('cat is mandatory.');
        // }
        // if(!$("#price").val()) {
        //     showAlert('price is mandatory.');
        // }

        var productId = parseInt($('#productId').val());
        var category = $("#category").val();
        var productName = $("#productName").val();
        var price = parseFloat($("#price").val());
        var stockQuantity = parseInt($("#stockQuantity").val());
        var fileInput = $('#fileUpload')[0];

        if(!category) {
            showAlert('danger', 'Please enter category');
            return;
        }
        if(!productName) {
            showAlert('danger', 'Please enter product name');
            return;
        }
        if(!price) {
            showAlert('danger', 'Please enter price');
            return;
        }
        if(!stockQuantity) {
            showAlert('danger', 'Please enter stock quantity');
            return;
        }

        var formData = new FormData();
        formData.append('productId', productId);
        formData.append('category', category);
        formData.append('productName', productName);
        formData.append('price', price);
        formData.append('stockQuantity', stockQuantity);

        if (fileInput.files.length > 0) {
            formData.append('fileUpload', fileInput.files[0]);
        }

    
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=updateProduct',
            type: 'POST',
            data: formData,
            processData: false, 
            contentType: false,
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('success',response.MESSAGE);
                    window.location.href = 'viewProducts.cfm';
                } else {
                    showAlert('danger', response.MESSAGE);
                    //window.location.href = 'viewProducts.cfm';
                }
            },
            error: function(xhr, status, error) {             
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    });
    $(document).on('click', '#updateCategoryButton', function() {
        var categoryId = parseInt($('#categoryId').val());
        var categoryName = $("#categoryName").val();

        if(!categoryName) {
            showAlert('danger', 'Please enter category');
            return;
        }
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=updateCategory',
            type: 'POST',
            data: {
                categoryId: categoryId,
                categoryName: categoryName
            },
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('success',response.MESSAGE);
                    window.location.href = 'viewCategories.cfm';
                } else {
                    showAlert('danger', response.MESSAGE);
                    //window.location.href = 'viewCategories.cfm';
                }
            },
            error: function(xhr, status, error) {             
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    });

    $('#updateOrderButton').on('click', function() {
        var saleId = $('#saleId').val();
        var customerId = $('#customerId').val();
        var saleDate = $('#saleDate').val();
        var productId = $('#productId').val();
        var productName = $('#productName').val();
        var quantity = $('#quantity').val();
        var price = $('#price').val();
        var totalAmount = $('#totalAmount').val();
        var status = $('#status').val();


        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=updateOrder',
            type: 'POST',
            data: {
                saleId: saleId,
                customerId: customerId,
                saleDate: saleDate,
                productId: productId,
                productName: productName,
                quantity: quantity,
                price: price,
                totalAmount: totalAmount,
                status: status
            },
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    console.log(response);
                    showAlert('success',response.MESSAGE);
                    window.location.href = 'viewOrders.cfm';
                } else {
                    console.log(response);
                    showAlert('danger', response.MESSAGE);
                    //window.location.href = 'viewOrders.cfm';
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    });

        // $(document).on('click', '#viewUsersButton', function() {
        //     $.ajax({
        //         url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getUsersForAdmin',
        //         type: 'GET',
        //         dataType: 'json',
        //         success: function(response) {
        //             if (response.SUCCESS) {
        //                 // Process the user data and display it
        //                 console.log(response.data); // Or render it to the UI
        //                 //window.location.href = 'viewUsers.cfm';
        //             } else {
        //                 alert('Error: ' + response.MESSAGE);
        //             }
        //         },
        //         error: function(xhr, status, error) {
        //             console.error('AJAX Error:', status, error);
        //             alert('An error occurred. Please try again later.');
        //         }
        //     });
        // });

        $('#exportUsers').on('click', function() {


            $.ajax({
                url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=exportUsersToExcel',
                type: 'GET',
                success: function(response) {
                    const blob = new Blob([response], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                    const url = window.URL.createObjectURL(blob);
    
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = 'users.xlsx';
                    document.body.appendChild(a);
                    a.click();
                    a.remove();
                    window.URL.revokeObjectURL(url);
                },
                error: function(xhr, status, error) {
                    console.error("Error exporting users:", error);
                    showAlert('danger',"An error occurred while exporting users. Please try again.");
                },
                xhrFields: {
                    responseType: 'blob'
                }
            });
        });

            $('#exportProducts').on('click', function() {


                $.ajax({
                    url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=exportProductsToExcel',
                    type: 'GET',
                    success: function(response) {
                        const blob = new Blob([response], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                        const url = window.URL.createObjectURL(blob);
        
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = 'products.xlsx';
                        document.body.appendChild(a);
                        a.click();
                        a.remove();
                        window.URL.revokeObjectURL(url);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error exporting products:", error);
                        showAlert('danger',"An error occurred while exporting products. Please try again.");
                    },
                    xhrFields: {
                        responseType: 'blob'
                    }
                });
            });

            $('#exportOrders').on('click', function() {


                $.ajax({
                    url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=exportOrdersToExcel',
                    type: 'GET',
                    success: function(response) {
                        const blob = new Blob([response], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                        const url = window.URL.createObjectURL(blob);
        
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = 'orders.xlsx';
                        document.body.appendChild(a);
                        a.click();
                        a.remove();
                        window.URL.revokeObjectURL(url);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error exporting orders:", error);
                        showAlert('danger',"An error occurred while exporting orders. Please try again.");
                    },
                    xhrFields: {
                        responseType: 'blob'
                    }
                });
            });

            $(document).on('click', '#viewSalesReportButton', function(event) {
                event.preventDefault();
                window.location.href = 'salesReports.cfm';
            });
});

