 let context = {};

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
    
    function handlebarsDropdown(context) {
        $.get('../templates/dropdown.hbs', function(templateData) {
            var source = templateData;
            var template = Handlebars.compile(source);
            var html = template(context);
            $('#dropdownHeader').html(html);
        });
    }

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getCategoriesForAjax',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log(data);
            handlebarsDropdown(data);   
            $('#result').html(JSON.stringify(data, null, 2));
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
            // console.log('Response Text:', xhr.responseText); 
            $('#result').html('Error fetching data');
        }
    });

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getUsersForAdmin',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log(data);  
            $('#result').html(JSON.stringify(data, null, 2));
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
            alert('An error occurred. Please try again later.');
        }
    });

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getProductsForAdmin',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log(data);  
            $('#result').html(JSON.stringify(data, null, 2));
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
            alert('An error occurred. Please try again later.');
        }
    });

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getCategoriesForAdmin',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log(data);  
            $('#result').html(JSON.stringify(data, null, 2));
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
            alert('An error occurred. Please try again later.');
        }
    });

    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getOrdersForAdmin',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log(data);  
            $('#result').html(JSON.stringify(data, null, 2));
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
            alert('An error occurred. Please try again later.');
        }
    });


    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=getUserBySession',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            //console.log(response);
            const userId = Object.keys(response)[0];
            const user = response[userId];
    
            if (user) {
                $('#userId').text(userId);
                $('#firstname').text(user.FIRSTNAME);
                $('#lastname').text(user.LASTNAME);
                $('#username').text(user.USERNAME);
                $('#email').text(user.EMAIL);
                $('#address').text(user.ADDRESS);
                $('#country').text(user.COUNTRY);
                $('#state').text(user.STATE);
                $('#zip').text(user.ZIP);
            } else {
                $('#profileContainer').html('<p>Error loading user data.</p>');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error fetching user details:', error);
            console.log('Response Text:', xhr.responseText);
            $('#profileContainer').html('<p>Error fetching user details.</p>');
        }
    });

    fetchCategories();

    $('#applyFilters').on('click', function () {
        var selectedCategories = [];
        $('.category-checkbox:checked').each(function () {
            selectedCategories.push($(this).val());
        });

        console.log('Selected Categories:', selectedCategories);
        fetchProducts(selectedCategories);
    });
    

    function populateCategoryFilters(categories) {
        var $filters = $('#categoryFilters');
        $filters.empty();
    
        categories.forEach(function (category) {
            $filters.append(
                `<div class="form-check">
                    <input class="form-check-input category-checkbox" type="checkbox" value="${category}" id="category_${category}">
                    <label class="form-check-label" for="category_${category}">
                        ${category.charAt(0).toUpperCase() + category.slice(1)}
                    </label>
                </div>`
            );
        });
    }

    function fetchCategories() {
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getCategories',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                //console.log('from fetch categories',data);
                populateCategoryFilters(data); 
                fetchProducts();
            },
            error: function (xhr, status, error) {
                console.error('Error fetching categories: ' + error);
                $('#result').html('Error fetching categories');
            }
        });
    }

    function fetchProducts(categories = []) {
        console.log('passing categories',categories);
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getProductsByCategory',
            type: 'GET',
            data: { categories: JSON.stringify(categories) },
            dataType: 'json',
            success: function (data) {
                handlebarsProductsList(data); 
            },
            error: function (xhr, status, error) {
                console.error('Error fetching products: ' + error);
                $('#result').html('Error fetching data');
            }
        });
    }

    function handlebarsProductsList(context) {
        $.get('../templates/productsList.hbs')
            .done(function (templateData) {
                Handlebars.registerHelper('keys', function (obj) {
                    return Object.keys(obj);
                });

                var template = Handlebars.compile(templateData);
                var html = template(context);
                $('#productsList').html(html);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }
    

    // function handlebarsProductsList(context) {
    //     $.get('../templates/productsList.hbs')
    //         .done(function(templateData) {
    //             Handlebars.registerHelper('keys', function(obj) {
    //                 return Object.keys(obj);
    //             });
                
    //             var template = Handlebars.compile(templateData);
    //             var html = template(context);
    //             $('#productsList').html(html);
    //         })
    //         .fail(function(jqXHR, textStatus, errorThrown) {
    //             console.error("Error fetching template:", textStatus, errorThrown);
    //             $('#result').html('Error fetching template');
    //         });
    // }

    
    // $.ajax({
    //     url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getProductsForAjax',
    //     type: 'GET',
    //     dataType: 'json',
    //     success: function(data) {
    //         //console.log(data);
    //         handlebarsProductsList(data);
    //     },
    //     error: function(xhr, status, error) {
    //         console.error('Error: ' + error);
    //         console.log('Response Text:', xhr.responseText);
    //         $('#result').html('Error fetching data');
    //     }
    // });


    function handlebarsWatchList(context) {
        $.get('../templates/watchList.hbs')
            .done(function(templateData) {
                Handlebars.registerHelper('keys', function(obj) {
                    return Object.keys(obj);
                });
                
                var template = Handlebars.compile(templateData);
                var html = template(context);
                $('#watchList').html(html);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }

    
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getWatchProducts',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log("watch data", data);
            handlebarsWatchList(data);
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
            console.log('Response Text:', xhr.responseText);
            $('#result').html('Error fetching data');
        }
    });

    function handlebarsCameraList(context) {
        $.get('../templates/cameraList.hbs')
            .done(function(templateData) {
                Handlebars.registerHelper('keys', function(obj) {
                    return Object.keys(obj);
                });
                
                var template = Handlebars.compile(templateData);
                var html = template(context);
                $('#cameraList').html(html);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }

    
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getCameraProducts',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log("camera data", data);
            handlebarsCameraList(data);
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
            console.log('Response Text:', xhr.responseText);
            $('#result').html('Error fetching data');
        }
    });

    function handlebarsDroneList(context) {
        $.get('../templates/droneList.hbs')
            .done(function(templateData) {
                Handlebars.registerHelper('keys', function(obj) {
                    return Object.keys(obj);
                });
                
                var template = Handlebars.compile(templateData);
                var html = template(context);
                $('#droneList').html(html);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }

    
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getDroneProducts',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log("drone data", data);
            handlebarsDroneList(data);
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
            console.log('Response Text:', xhr.responseText);
            $('#result').html('Error fetching data');
        }
    });

    function handlebarsMobileList(context) {
        $.get('../templates/mobileList.hbs')
            .done(function(templateData) {
                Handlebars.registerHelper('keys', function(obj) {
                    return Object.keys(obj);
                });
                
                var template = Handlebars.compile(templateData);
                var html = template(context);
                $('#mobileList').html(html);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }

    
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/products.cfc?method=getMobileProducts',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log("mobile data", data);
            handlebarsMobileList(data);
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
            console.log('Response Text:', xhr.responseText);
            $('#result').html('Error fetching data');
        }
    });

    function handlebarsCategoriesReport(context) {
        $.get('../templates/reports.hbs')
            .done(function(templateData) {
                var template = Handlebars.compile(templateData);
                var html = template(context);
                //console.log(html);
                $('#salesReport').html(html);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }
    
    // AJAX call to getCategoriesReport
    $.ajax({
        url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=getCategoriesReport',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log("categories report",data);
            handlebarsCategoriesReport(data);
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
            console.log('Response Text:', xhr.responseText);
            $('#result').html('Error fetching data');
        }
    });
    
    

    $(document).on('click', '#submitLogin', function(event) {
        event.preventDefault();
        let username = document.getElementById("username").value;
        let password = document.getElementById("password").value;
        AjaxuserLogin({
            "username": username,
            "password": password
        });
        
    });

    function AjaxuserLogin(credentials) {
        
    
    
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=loginForAjax',
            type: 'POST',
            data: {
                USERNAME: credentials.username, 
                PASSWORD: credentials.password
            },
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    //console.log(response);
                    window.location.href = 'assets/templates/dashboard.cfm';
                } else {
                    console.log(response.MESSAGE);
                    showAlert('danger', response.MESSAGE);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    }

    $(document).on('click', '#submitAdminLogin', function() {
        let username = document.getElementById("username").value;
        let password = document.getElementById("password").value;
        AjaxAdminLogin({
            "username": username,
            "password": password
        });
        
    });

    function AjaxAdminLogin(credentials) {
        
    
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=AdminloginForAjax',
            type: 'POST',
            data: {
                USERNAME: credentials.username, 
                PASSWORD: credentials.password
            },
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    //console.log(response);
                    window.location.href = 'assets/templates/adminDashboard.cfm';
                } else {
                    //console.log(response);
                    showAlert('danger',response.MESSAGE);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    }


    
    
    function handlebarsCartList(context) {
        $.get('../templates/cart.hbs')
            .done(function(templateData) {
                Handlebars.registerHelper('keys', function(obj) {
                    return Object.keys(obj);
                });
                
                var template = Handlebars.compile(templateData);
                var html = template(context);
                $('#carItemsContainer').html(html);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching template:", textStatus, errorThrown);
                $('#result').html('Error fetching template');
            });
    }
    

    $(document).on('click', '#addUserButton', function(event) {
        event.preventDefault();
        $('#addUserModal').modal('show');
    });

    $('#addUserDB').on('click', function() {
        var formData = {
            username: $('#addusername').val(),
            password: $('#addpassword').val(),
            email: $('#addemail').val(),
            role: $('#addrole').val()
        };

        
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=addUser',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('success','User added successfully!');
                    $('#addUserModal').modal('hide'); 
                    window.location.href = 'viewUsers.cfm';
                } else {
                    //console.log(response);
                    showAlert('danger',response.MESSAGE);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                alert('An error occurred. Please try again later.');
            }
        });
    });


    
    $(document).on('click', '#addProductButton', function(event) {
        event.preventDefault();
        $('#addProductModal').modal('show');
    });

    $('#addProductDB').on('click', function(e) {
        e.preventDefault();
        var formData = new FormData();
        formData.append('productName', $('#addproductName').val());
        formData.append('category', $('#addcategory').val());
        formData.append('price', parseFloat($('#addprice').val()));
        formData.append('stockQuantity', parseInt($('#addstockQuantity').val()));
        formData.append('productFile', $('#addproductFile')[0].files[0]);

    
    
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=addProduct',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('success','Product added successfully!');
                    $('#addProductModal').modal('hide');
                    window.location.href = 'viewProducts.cfm';
                } else {
                    //console.log(response);
                    showAlert('danger',response.MESSAGE);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                showAlert('danger','An error occurred. Please try again later.');
            }
        });
    });
    
    $(document).on('click', '#editCustomerDetails', function(event) {
        event.preventDefault();
        window.location.href = 'editCustomer.cfm';
    });

    
    $(document).on('click', '#addCategoryButton', function(event) {
        event.preventDefault();
        $('#addCategoryModal').modal('show');
    });

    $('#addCategoryDB').on('click', function() {
        var formData = {
            categoryName: $('#addcategoryName').val()
            };

        
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/Adminuser.cfc?method=addCategory',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    showAlert('Category added successfully!');
                    window.location.href = 'viewCategories.cfm';
                } else {
                    console.log(response);
                    showAlert('danger', response.MESSAGE);
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                alert('An error occurred. Please try again later.');
            }
        });
    });

    $(document).on('click', '#backToLogin', function(event) {
        event.preventDefault();
        window.location.href = '/Eshopper/public/';
    });

    $(document).on('click', '#viewUsersButton', function(event) {
        event.preventDefault();
        window.location.href = 'viewUsers.cfm';
    });

    $(document).on('click', '#viewProductsButton', function(event) {
        event.preventDefault();
        window.location.href = 'viewProducts.cfm';
    });

    $(document).on('click', '#viewCategoriesButton', function(event) {
        event.preventDefault();
        window.location.href = 'viewCategories.cfm';
    });

    $(document).on('click', '#viewOrdersButton', function(event) {
        event.preventDefault();
        window.location.href = 'viewOrders.cfm';
    });


        $('#logoutButton').on("click",function(event) {
           event.preventDefault();
           $.ajax({
               type: 'POST',
               url: '../../components/user.cfc?method=logoutUser', 
               dataType: 'json', 
               success: function(response) {
                   if (response.SUCCESS) {
                           window.location.href = '/Eshopper/public/';
                           //alert('Logged Out Successfully.');
                       } 
                       else {
                            alert(response.MESSAGE);
                       } 
               },
               error: function(xhr, status, error) {
                   alert('AJAX error: ' + error);
               }
           });
        });

       

    
    $(document).on('click', '#needToRegister', function() {
        handlebarsRegister(context);
    });

    
    $(document).on('click', '#alreadyRegisterred', function() {
        handlebarsFirst(context);
    })

    handlebarsFirst(context);

    $(document).on('click', '#adminLogin', function() {
        handlebarsAdmin(context);
    })

    $(document).on('click', '#backtolisting', function() {
        document.getElementById('index-nav').style.display = 'none';
        document.getElementById('index-p').style.display = 'none';
        handlebarsUserList({
            "firstname": sessionUserFirstName,
            "lastname": sessionUserSecondName,
            "email": sessionUserEmail,
        });
    })

    $(document).on('click', '#forgotPassword', function() {
        handlebarsForgot(context);
    });

    $(document).on('click', '#submitForgotPassword', function(event) {
        event.preventDefault();
        let email = document.getElementById("email").value;
        passwordReset({
            "email": email,
        });
        
    });

    function passwordReset(userinfo) {


        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=sendPasswordResetEmail',
            type: 'POST',
            data: {
                email: userinfo.email
            },
            dataType: 'json',
            success: function(response) {
                if (response.SUCCESS) {
                    console.log(response);
                    showAlert('success',"Password reset email sent! Please check your inbox.");
                } else {
                    console.log(response);
                    showAlert('danger',response.MESSAGE || 'Mail Sending failed. Please try again.');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error sending password reset email:', status, error);
                showAlert('danger',"Failed to send password reset email. Please try again.");
            }
        });
        
    }
    

    $(document).on('click', '#registersubmitbutton', function() {
        var firstName = $('#firstName').val();
        var lastName = $('#lastName').val();
        var userName = $('#username').val();
        var email = $('#email').val();
        var password = $('#password').val();
        var address = $('#address').val();
        var country = $('#country').val();
        var state = $('#state').val();
        var zip = $('#zip').val();
        
        var dataToSend = {
            firstName: firstName,
            lastName: lastName,
            userName: userName,
            email: email,
            password: password,
            address: address,
            country: country,
            state: state,
            zip: zip
        };

    
    
        $.ajax({
            url: 'http://localhost:8500/Eshopper/public/components/user.cfc?method=registerUser',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(dataToSend),
            dataType: 'json',
            
            success: function(response) {
                console.log(response)
                if(response.SUCCESS == true){
                    showAlert('success',response.MESSAGE);
                    window.location.href = '/Eshopper/public/';
                }else{
                    showAlert('danger',response.MESSAGE);
                }
            }
            ,
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                showAlert('danger',error);
            }
        });
    });
    

    $(document).on('click', '#gotoProductDetails', function() {
        handlebarsProductDetails(context);
    })

});