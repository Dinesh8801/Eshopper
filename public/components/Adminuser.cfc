component {
    remote string function AdminloginForAjax(string username, string password) returnformat="JSON" {
        
        local.username = arguments.username;
        local.password = arguments.password;

        if (len(trim(local.UserName)) EQ 0) {
            return serializeJSON({
                success = false,
                message = "Username is mandatory."
            });
        }
        if (len(trim(local.Password)) LT 9) {
            return serializeJSON({
                success = false,
                message = "Password length must be more than 8."
            });
        }


        var userCheck = queryExecute(
            "SELECT UserID, UserName, Password, Email, UserRole FROM martUsers WHERE userName = :userName",
            { userName = local.username },
            { datasource = "martDSN" }
        );

        if (userCheck.recordCount == 0) {
            return serializeJSON({
                success = false,
                message = "User does not exist."
            });
        }

        if (userCheck.recordCount == 1 && password != userCheck.password) {
            return serializeJSON({
                success = false,
                message = "Password does not match."
            });
        }

        if (userCheck.recordCount == 1 && password == userCheck.password) {
            session.isLoggedIn = true;
            session.userId = userCheck.UserId;
            session.username = userCheck.username;
            session.userrole = userCheck.userrole;
            session.email = userCheck.email;
            

            return serializeJSON({
                success = true,
                message = "User authenticated successfully.",
                userId = userCheck.UserId,
                username = userCheck.username,
                userrole = userCheck.userrole,
                email = userCheck.email
            });
        }

        return serializeJSON({
            success = false,
            message = "An unexpected error occurred."
        });
    }

    remote struct function addUser(string username, string password, string email, string role) returnformat="JSON" {
        var result = {};
        var hashedPassword = Hash(password, "SHA-256");
        local.username = arguments.userName;
        local.email = arguments.email;
        local.password = arguments.password;
        local.role = arguments.role;
      
        if (len(trim(local.username)) EQ 0) {
            result.success = false;
            result.message = "Username is mandatory.";
            return result;
        }
    
         
        if (len(trim(local.password)) LT 9) {
            result.success = false;
            result.message = "Password must be at least 9 characters.";
            return result;
        }
    
       
        if (len(trim(local.email)) EQ 0) {
            result.success = false;
            result.message = "Email is mandatory.";
            return result;
        }
        if (!isValid("email", local.email)) {
            result.success = false;
            result.message = "Invalid email format.";
            return result;
        }

        if (NOT REFindNoCase("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$", local.email)) {
            result.success = false;
            result.message = "Invalid email format provide domain.";
            return result;
        }
    
       
        var existingUserCheck = queryExecute(
            "SELECT UserID FROM martUsers WHERE UserName = :username OR Email = :email",
            {
                username = username,
                email = email
            },
            { datasource = "martDSN" }
        );
    
        if (existingUserCheck.recordCount > 0) {
            result.success = false;
            result.message = "Username or email already exists.";
            return result;
        }
    
        
        try {
            queryExecute(
                "INSERT INTO martUsers (userName, Password, Email, userRole) VALUES (:username, :hashedPassword, :email, :role);",
                {
                    username = username,
                    hashedPassword = hashedPassword,
                    email = email,
                    role = role
                },
                { datasource = "martDSN" }
            );
    
            result.success = true;
            result.message = "User added successfully!";
        } catch (any e) {
            result.success = false;
            result.message = "Database error: " & e.message & " " & e.detail;
        }
    
        return result;  
    }
    


    remote struct function addProduct( string productName, string category, numeric price, numeric stockQuantity, any productFile) returnformat="JSON" {
        var result = {};
        var uploadDirectory = "C:/ColdFusion2023/cfusion/wwwroot/Eshopper/public/uploads";
        var productPath = "";

        local.productName = arguments.productName;
        local.price = arguments.price;
        local.stockQuantity = arguments.stockQuantity;

        if (len(trim(local.productName)) EQ 0) {
            result.success = false;
            result.message = "productName is mandatory.";
            return result;
        
        }
        if((not isNumeric(local.price))) {
            result.success = false;
            result.message = "price must be number.";
            return result;
        }
        if (isNull(local.price)) {
            result.success = false;
            result.message = "price is mandatory.";
            return result;
        }
        if((local.price) LT 0) {
            result.success = false;
            result.message = "price should be positive.";
            return result;
        }
        if (isNull(local.stockQuantity) OR (not isNumeric(local.stockQuantity))) {
            result.success = false;
            result.message = "Stock Quantity is mandatory.";
            return result;
        }
        if((local.stockQuantity) LT 0) {
            result.success = false;
            result.message = "stockQuantity should be positive.";
            return result;
        }
        if(!structKeyExists(arguments, "productFile") OR len(arguments.productFile) EQ 0) {
            result.success = false;
            result.message = "Product Image is mandatory.";
            return result;
        }

        try {
            if (structKeyExists(arguments, "productFile")) {
                try {
                    var uploadResult = "";
                        uploadResult = fileUpload(
                        destination = uploadDirectory,
                        fileField = "productFile",
                        mimetype = "image/jpeg" 
                    );
                    if (not listFindNoCase("jpg,jpeg", uploadResult.serverFileExt)) {
                        result.success = false;
                        result.message = "Product Image is mandatory.";
                        return result;
                        }
                    productPath = "../../uploads/" & uploadResult.SERVERFILE;

                } catch (any e) {
                    result.success = false;
                    result.message = "Upload File" & uploadResult;
                    return result;
                }
                
            } else {
                result.success = false;
                result.message = "Product Image is mandatory.";
                return result;
            }

            queryExecute(
                "INSERT INTO Products (productName, category, price, stockQuantity, productPath) VALUES (:productName, :category, :price, :stockQuantity, :productPath);",
                {
                    productName = arguments.productName,
                    category = arguments.category,
                    price = arguments.price,
                    stockQuantity = arguments.stockQuantity,
                    productPath = productPath
                },
                { datasource = "martDSN" }
            );

            result.success = true;
            result.message = "Product added successfully!";
        } catch (any e) {
            result.success = false;
            result.message = "Database error: " & e.message & " " & e.detail;
        }

        return result;
    }

    remote struct function addCategory(string categoryName) returnformat="JSON" {
        var result = {};
        if (len(trim(arguments.categoryName)) EQ 0) {

            result.success = false;
            result.message = "Category Name is mandatory.";
            return result;
        }

        var existingCategoryCheck = queryExecute(
            "SELECT CategoryID FROM Categories WHERE CategoryName = :categoryName",
            {
                categoryName = categoryName
            },
            { datasource = "martDSN" }
        );
    
        if (existingCategoryCheck.recordCount > 0) {
            result.success = false;
            result.message = "Category already exists.";
            return result;
        } else {
            try {
                queryExecute(
                    "INSERT INTO Categories (categoryName) VALUES (:categoryName);",
                    {
                        categoryName = categoryName
                    },
                    { datasource = "martDSN" }
                );
        
                result.success = true;
                result.message = "Category added successfully!";
            } catch (any e) {
                result.success = false;
                result.message = "Database error: " & e.message & e.detail;
            }
        }
            
        
    
        return result;
    }

    remote struct function updateUser(string firstname,string lastname,string username, string address, string email, string password, string userrole, string country, string state, string zip) returnformat="JSON" {
        var result = {};
        var isHashed = false;
        if (len(trim(arguments.password)) EQ 64 && refind("^[a-fA-F0-9]{64}$", trim(arguments.password))) {
            isHashed = true;
        }

        var hashedPassword = isHashed ? trim(arguments.password) : Hash(arguments.password, "SHA-256");

        if (len(trim(arguments.firstName)) EQ 0) {
            result.success = false;
            result.message = "Firstname is mandatory.";
            return result;
        }
        if (len(trim(arguments.lastName)) EQ 0) {
            result.success = false;
            result.message = "Lastname is mandatory.";
            return result;
        }
        if (len(trim(arguments.UserName)) EQ 0) {

            result.success = false;
            result.message = "Username is mandatory.";
            return result;
        }
        if (len(trim(arguments.Email)) EQ 0) {

            result.success = false;
            result.message = "Email is mandatory.";
            return result;
        }

        if (len(trim(arguments.password)) EQ 0) {

            result.success = false;
            result.message = "Password is mandatory.";
            return result;
        }
        if (len(trim(arguments.password)) LT 8) {

            result.success = false;
            result.message = "Password length must be atleast 8 characters.";
            return result;
        }
        if (!isValid("email", arguments.Email)) {

            result.success = false;
            result.message = "Invalid email format.";
            return result;
        }
        if (NOT REFindNoCase("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$", arguments.Email)) {
            result.success = false;
            result.message = "Invalid email format provide domain.";
            return result;
        }
        if (len(trim(arguments.zip)) EQ 0) {
            result.success = false;
            result.message = "Zip is mandatory.";
            return result;
        }
        if (!len(trim(arguments.zip)) EQ 6) {

            result.success = false;
            result.message = "Invalid Zip Code.";
            return result;
        }

        try {

            queryExecute(
                "UPDATE martUsers SET FirstName = :firstname, LastName = :lastname, UserName = :username, Address = :address, Email = :email, Password = :password, UserRole = :userrole ,Country = :country, State = :state, Zip = :zip WHERE UserName = :username",
                {
                    firstname = arguments.firstname,
                    lastname = arguments.lastname,
                    username = arguments.username,
                    address = arguments.address,
                    email = arguments.email,
                    password = hashedPassword,
                    userrole = arguments.userrole,
                    country = arguments.country,
                    state = arguments.state,
                    zip = arguments.zip
                },
                { datasource = "martDSN" }
            );

            result.success = true;
            result.message = "User updated successfully!";
        } catch (any e) {
            result.success = false;
            result.message = "Database error: " & e.message;
        }

        return result;
    }
    

    remote struct function updateCategory(numeric categoryId, string categoryName) returnformat="JSON" {
        var result = {};

        if (len(trim(arguments.categoryName)) EQ 0) {
            result.success = false;
            result.message = "Category Name is mandatory.";
            return result;
        }
        try {
            queryExecute(
                "UPDATE Categories SET CategoryName = :categoryName WHERE CategoryID = :categoryId",
                {
                    categoryName = arguments.categoryName,
                    categoryId = arguments.categoryId
                },
                { datasource = "martDSN" }
            );

            result.success = true;
            result.message = "Category updated successfully!";
        } catch (any e) {
            result.success = false;
            result.message = "Database error: " & e.message;
        }

        return result;
    }

    remote struct function updateProduct(numeric productId, string category, string productName, numeric price, numeric stockQuantity, any fileUpload) returnformat="JSON" {
        var result = {};
        var uploadDirectory = "C:/ColdFusion2023/cfusion/wwwroot/Eshopper/public/uploads";
        var productPath = "";

        if (len(trim(arguments.productName)) EQ 0) {
            result.success = false;
            result.message = "productName is mandatory.";
            return result;
        }
        if (len(trim(arguments.category)) EQ 0) {
            result.success = false;
            result.message = "category is mandatory.";
            return result;
        }
        if (isNull(arguments.price) OR (not isNumeric(arguments.price))) {
            result.success = false;
            result.message = "price is mandatory.";
            return result;
        }
        if((arguments.price) LT 0) {
            result.success = false;
            result.message = "price should be positive.";
            return result;
        }
        if (isNull(arguments.stockQuantity) OR (not isNumeric(arguments.stockQuantity))) {
            result.success = false;
            result.message = "Stock Quantity is mandatory.";
            return result;
        }
        if((arguments.stockQuantity) LT 0) {
            result.success = false;
            result.message = "stockQuantity should be positive.";
            return result;
        }
        if (structKeyExists(arguments, "fileUpload")) {
            try {
                var uploadResult = fileUpload(
                    destination = uploadDirectory,
                    fileField = "fileUpload",
                    mimetype = "image/jpeg"
                );
                //productPath = uploadResult.SERVERDIRECTORY & "\" & uploadResult.SERVERFILE;
                productPath = "../../uploads/" & uploadResult.SERVERFILE;

            } catch (any e) {
                result.success = false;
                result.message = "File upload error: " & e.message;
                return result;
            }
        }
        
        if (productPath EQ "") {
            getExistingPath = queryExecute(
                "SELECT ProductPath FROM products WHERE productId = :productid",
                [productid = arguments.productId],
                {datasource = "martDSN"}
            );
        
            productPath = getExistingPath.productPath;
        }
        

        try {
            queryExecute(
                "UPDATE Products SET Category = :category, ProductName = :ProductName, Price = :Price, stockQuantity = :stockQuantity, ProductPath = :ProductPath  WHERE ProductID = :productId",
                {
                    category = arguments.category,
                    productName = arguments.productName,
                    price = arguments.price,
                    stockQuantity = arguments.stockQuantity,
                    productPath = productPath,
                    productId = arguments.productId
                },
                { datasource = "martDSN" }
            );

            result.success = true;
            result.message = "Product updated successfully!";
        } catch (any e) {
            result.success = false;
            result.message = "Database error: " & e.message;
        }

        return result;
    }

    remote struct function updateOrder(numeric saleId, numeric customerId, date saleDate, numeric productId, string productName, numeric quantity, numeric price, numeric totalAmount, string status) returnformat="JSON" {
        var result = {};
        
        try {
            queryExecute(
                "UPDATE Sales SET CustomerID = :customerId, SaleDate = :saleDate, ProductID = :productId, ProductName = :productName, Quantity = :quantity, Price = :price, TotalAmount = :totalAmount, Status = :status WHERE SaleID = :saleId",
                {
                    customerId = arguments.customerId,
                    saleDate = arguments.saleDate,
                    productId = arguments.productId,
                    productName = arguments.productName,
                    quantity = arguments.quantity,
                    price = arguments.price,
                    totalAmount = arguments.totalAmount,
                    status = arguments.status,
                    saleId = arguments.saleId
                },
                { datasource = "martDSN" }
            );
    
            result.success = true;
            result.message = "Order updated successfully!";
        } catch (any e) {
            result.success = false;
            result.message = "Database error: " & e.message & " | Query: " & e.sql;
        }
    
        return result;
    }
    
    remote struct function getUserById(numeric userId) returnformat="JSON" {
        var user = {};

        var getUser = queryExecute(
            "SELECT UserId, firstname, lastname, username, password, UserRole, email, address, country, state, zip FROM martUsers WHERE UserID = :userId",
            { userId = userId },
            { datasource = "martDSN" }
        );

        if (getUser.recordCount EQ 1) {
            user = {
                "userId": getUser.UserId[1],
                "firstname": getUser.firstname[1],
                "lastname": getUser.Lastname[1],
                "username": getUser.Username[1],
                "password": getUser.Password[1],
                "userrole": getUser.UserRole[1],
                "email": getUser.Email[1],
                "address": getUser.Address[1],
                "country": getUser.Country[1],
                "state": getUser.State[1],
                "zip": getUser.Zip[1]
            };
        }
        
        return user;
    }

    remote struct function getProductById(numeric productId) returnformat="JSON" {
        var product = {};
        
        var getProduct = queryExecute(
            "SELECT ProductID, ProductName, Category, Price, StockQuantity, ProductPath FROM Products WHERE ProductID = :productId",
            { productId = productId },
            { datasource = "martDSN" }
        );

        if (getProduct.recordCount EQ 1) {
            product = {
                "productId": getProduct.ProductID[1],
                "productName": getProduct.ProductName[1],
                "category": getProduct.Category[1],
                "price": getProduct.Price[1],
                "stockQuantity": getProduct.StockQuantity[1],
                "productPath": getProduct.ProductPath[1]
            };
        }

        return product;
    }

    remote struct function getOrderById(numeric saleId) returnformat="JSON" {
        var order = {};
        
        var getOrder = queryExecute(
            "SELECT SaleID, CustomerID, SaleDate, ProductID, ProductName, Quantity, Price, TotalAmount, Status FROM Sales WHERE SaleID = :saleId",
            { saleId = saleId },
            { datasource = "martDSN" }
        );

        if (getOrder.recordCount EQ 1) {
            order = {
                "SaleID": getOrder.SaleID[1],
                "CustomerID": getOrder.CustomerID[1],
                "SaleDate": DateFormat(getOrder.SaleDate[1], "yyyy-mm-dd") & " " & TimeFormat(getOrder.SaleDate[1], "HH:mm:ss"),
                "ProductID": getOrder.ProductID[1],
                "ProductName": getOrder.ProductName[1],
                "Quantity": getOrder.Quantity[1],
                "Price": getOrder.Price[1],
                "TotalAmount": getOrder.TotalAmount[1],
                "Status": getOrder.Status[1]
            };
        }

        return order;
    }

    remote struct function getCategoryById(numeric categoryId) returnformat="JSON" {
        var result = {};

        var getCategory = queryExecute(
            "SELECT CategoryID, CategoryName FROM Categories WHERE CategoryID = :categoryId",
            { categoryId = categoryId },
            { datasource = "martDSN" }
        );

        if (getCategory.recordCount GT 0) {
            result = {
                "categoryId": getCategory.CategoryID[1],
                "categoryName": getCategory.CategoryName[1]
            };
        }

        return result;
    }

    remote struct function deleteProduct() returnformat="JSON" {
        var jsonData = deserializeJSON(toString(getHttpRequestData().content));
        var productId = jsonData.productId;
        var result = {};

        try {
            queryExecute(
                "DELETE FROM Products WHERE ProductID = :productId",
                { productId: { value: productId, cfsqltype: "cf_sql_integer" } },
                { datasource = "martDSN" }
            );

            result.success = true;
            result.message = "Product deleted successfully.";
        } catch (any e) {
            result.success = false;
            result.message = "An error occurred: " & e.message;
        }

        return result;
    }

    remote struct function deleteUser() returnformat="JSON" {
        var jsonData = deserializeJSON(toString(getHttpRequestData().content));
        var userId = jsonData.userId;
        var result = {};
    
        try {
            queryExecute(
                "DELETE FROM martUsers WHERE UserID = :userId", 
                {userId: {value: userId, cfsqltype='cf_sql_integer'}}, 
                { datasource = "martDSN" }
            );
    
            result.success = true;
            result.message = "User deleted successfully.";
        } catch (any e) {
            result.success = false;
            result.message = "An error occurred: " & e.message & " | StackTrace: " & e.stackTrace;
        }
    
        return result;
    }

    remote struct function deleteCategory() returnformat="JSON" {
        var jsonData = deserializeJSON(toString(getHttpRequestData().content));
        var categoryId = jsonData.categoryId;
        var result = {};
    
        try {
            queryExecute(
                "DELETE FROM Categories WHERE CategoryID = :categoryId", 
                {categoryId: {value: categoryId, cfsqltype='cf_sql_integer'}},  
                { datasource = "martDSN" }
            );
           
                result.success = true;
                result.message = "Category deleted successfully.";
        } catch (any e) {
            result.success = false;
            result.message = "An error occurred: " & e.message;
        }
    
        return result;
    }
    
    
    remote struct function getUsersForAdmin() returnformat="JSON" {
        var result = {};
    
        try {
            var userQuery = queryExecute(
                "SELECT UserID, UserName, Password, Email, UserRole FROM martUsers",
                [],
                { datasource = "martDSN" }
            );
    
            if (userQuery.recordCount > 0) {
                for (var i = 1; i <= userQuery.recordCount; i++) {
                    var row = userQuery.getRow(i);
                    var userId = row.userId;
                    var userName = row.userName;
                    var password = row.password;
                    var email = row.email;
                    var userRole = row.userRole;

                    if (!structKeyExists(result, userId)) {
                        result[userId] = {};
                    }

                    result[userId] = {
                        userName: userName,
                        password: password,
                        email: email,
                        userRole: userRole
                    };

                }
            }
    
        } catch (any e) {
            result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
        }
    
        return result;
    }

    remote struct function getCategoriesForAdmin() returnformat="JSON" {
        var result = {};
    
        try {
            var categoryQuery = queryExecute(
                "SELECT CategoryID, CategoryName FROM Categories",
                [],
                { datasource = "martDSN" }
            );
    
            if (categoryQuery.recordCount > 0) {
                for (var i = 1; i <= categoryQuery.recordCount; i++) {
                    var row = categoryQuery.getRow(i);
                    var categoryId = row.categoryId;
                    var categoryName = row.categoryName;
                
                    if (!structKeyExists(result, categoryId)) {
                        result[categoryId] = {};
                    }

                    result[categoryId] = {
                        categoryName: categoryName
                    };

                }
            }
    
        } catch (any e) {
            result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
        }
    
        return result;
    }


    remote struct function getProductsForAdmin() returnformat="JSON" {
        var result = {};
    
        try {
            var productQuery = queryExecute(
                "SELECT ProductID, ProductName, Category, Price, StockQuantity, ProductPath FROM Products",
                [],
                { datasource = "martDSN" }
            );
    
            if (productQuery.recordCount > 0) {
                for (var i = 1; i <= productQuery.recordCount; i++) {
                    var row = productQuery.getRow(i);
                    var productId = row.productId;
                    var productName = row.productName;
                    var category = row.category;
                    var price = row.price;
                    var stockQuantity = row.stockQuantity;
                    var productPath = row.productPath;

                    if (!structKeyExists(result, productId)) {
                        result[productId] = {};
                    }

                    result[productId] = {
                        productName: productName,
                        category: category,
                        price: price,
                        stockQuantity: stockQuantity,
                        productPath: productPath
                    };

                }
            }
    
        } catch (any e) {
            result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
        }
    
        return result;
    }
    
    remote struct function getOrdersForAdmin() returnformat="JSON" {
        var result = {};
    
        try {
            var orderQuery = queryExecute(
                "SELECT SaleID, CustomerID, SaleDate, ProductID, ProductName, Quantity, Price, TotalAmount, Status FROM Sales ORDER BY SaleDate DESC",
                [],
                { datasource = "martDSN" }
            );
    
            if (orderQuery.recordCount > 0) {
                for (var i = 1; i <= orderQuery.recordCount; i++) {
                    var row = orderQuery.getRow(i);
                    var SaleID = row.SaleID;
                    var CustomerID = row.CustomerID;
                    var SaleDate = row.SaleDate;
                    var ProductID = row.ProductID;
                    var ProductName = row.ProductName;
                    var Quantity = row.Quantity;
                    var Price = row.Price;
                    var TotalAmount = row.TotalAmount;
                    var Status = row.Status;


                    if (!structKeyExists(result, SaleID)) {
                        result[SaleID] = {};
                    }

                    result[SaleID] = {
                        CustomerID: CustomerID,
                        SaleDate: SaleDate,
                        ProductID: ProductID,
                        ProductName: ProductName,
                        Quantity: Quantity,
                        Price: Price,
                        TotalAmount: TotalAmount,
                        Status: Status
                    };

                }
            }
    
        } catch (any e) {
            result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
        }
    
        return result;
    }

    remote void function exportUsersToExcel() {
        var jsonDataStruct = {};
        var usersData = getUsersForAdmin();
    
        jsonDataStruct.headers = [
            "User ID",
            "Username",
            "Password",
            "Email",
            "Role"
        ];
    
        jsonDataStruct.data = [];
    
        for (var userId in usersData) {
            var user = usersData[userId];
    
            arrayAppend(jsonDataStruct.data, {
                "User ID": userId,
                "Username": user.USERNAME,
                "Password": user.PASSWORD,
                "Email": user.EMAIL,
                "Role": user.USERROLE
            });
        }
    
        var excelFilePath = generateExcelFileUsers(jsonDataStruct);
        
        if (fileExists(excelFilePath)) {
            var fileContent = fileReadBinary(excelFilePath);
    
            try {
                fileDelete(excelFilePath);
            } catch (any e) {
                writeOutput("Error deleting file: " & e.message);
                return; 
            }
    
            cfheader(name="Content-Type", value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            cfheader(name="Content-Disposition", value="attachment; filename=users.xlsx");
            cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable=fileContent);
        } else {
            writeOutput("Error: The specified file does not exist.");
        }
    }
    
    remote string function generateExcelFileUsers(struct data) {
        var spreadsheet = spreadsheetNew("Users");
        var headers = arguments.data.headers;
        var rowIndex = 1;
    
        if (isArray(headers)) {
            for (var i = 1; i <= arrayLen(headers); i++) {
                spreadsheetSetCellValue(spreadsheet, headers[i], rowIndex, i);
            }
        } else {
            writeOutput("Error: Headers are not an array.");
            return "";
        }
    
        rowIndex = 2;
        for (var row in arguments.data.data) {
            if (isStruct(row)) {
                var colIndex = 1;
                for (var header in headers) {
                    var cellValue = row[header] ?: "";
                    spreadsheetSetCellValue(spreadsheet, cellValue, rowIndex, colIndex);
                    colIndex++;
                }
                rowIndex++;
            } else {
                writeOutput("Error: Row data is not a struct.");
            }
        }
    
        var excelFilePath = expandPath("./users.xlsx");
        if (fileExists(excelFilePath)) {
            fileDelete(excelFilePath);
        }
        
        spreadsheetWrite(spreadsheet, excelFilePath);
        return excelFilePath;
    }

    remote void function exportProductsToExcel() {
        var jsonDataStruct = {};
        var productsData = getProductsForAdmin();
    
        jsonDataStruct.headers = [
            "Product ID",
            "Product Name",
            "Category",
            "Price",
            "Product Path"
        ];
    
        jsonDataStruct.data = [];
    
        for (var productId in productsData) {
            var product = productsData[productId];
    
            arrayAppend(jsonDataStruct.data, {
                "Product ID": productId,
                "Product Name": product.PRODUCTNAME,
                "Category": product.CATEGORY,
                "Price": product.PRICE,
                "Product Path": product.PRODUCTPATH
            });
        }
    
        var excelFilePath = generateExcelFileProducts(jsonDataStruct);
        
        if (fileExists(excelFilePath)) {
            var fileContent = fileReadBinary(excelFilePath);
    
            try {
                fileDelete(excelFilePath);
            } catch (any e) {
                writeOutput("Error deleting file: " & e.message);
                return;
            }
    
            cfheader(name="Content-Type", value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            cfheader(name="Content-Disposition", value="attachment; filename=products.xlsx");
            cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable=fileContent);
        } else {
            writeOutput("Error: The specified file does not exist.");
        }
    }
    
    remote string function generateExcelFileProducts(struct data) {
        var spreadsheet = spreadsheetNew("Products");
        var headers = arguments.data.headers;
        var rowIndex = 1;
    
        if (isArray(headers)) {
            for (var i = 1; i <= arrayLen(headers); i++) {
                spreadsheetSetCellValue(spreadsheet, headers[i], rowIndex, i);
            }
        } else {
            writeOutput("Error: Headers are not an array.");
            return "";
        }
    
        rowIndex = 2;
        for (var row in arguments.data.data) {
            if (isStruct(row)) {
                var colIndex = 1;
                for (var header in headers) {
                    var cellValue = row[header] ?: "";
                    spreadsheetSetCellValue(spreadsheet, cellValue, rowIndex, colIndex);
                    colIndex++;
                }
                rowIndex++;
            } else {
                writeOutput("Error: Row data is not a struct.");
            }
        }
    
        var excelFilePath = expandPath("./products.xlsx");
        if (fileExists(excelFilePath)) {
            fileDelete(excelFilePath);
        }
        
        spreadsheetWrite(spreadsheet, excelFilePath);
        return excelFilePath;
    }
    
    remote void function exportOrdersToExcel() {
        var jsonDataStruct = {};
        var ordersData = getOrdersForAdmin();
    
        jsonDataStruct.headers = [
            "Order ID",
            "Customer ID",
            "Order Date",
            "Product ID",
            "Product Name",
            "Quantity",
            "Price",
            "Total Amount",
            "Status"
        ];
    
        jsonDataStruct.data = [];
    
        for (var orderId in ordersData) {
            var order = ordersData[orderId];
    
            arrayAppend(jsonDataStruct.data, {
                "Order ID": orderId,
                "Customer ID": order.CUSTOMERID,
                "Order Date": order.SALEDATE,
                "Product ID": order.PRODUCTID,
                "Product Name": order.PRODUCTNAME,
                "Quantity": order.QUANTITY,
                "Price": order.PRICE,
                "Total Amount": order.TOTALAMOUNT,
                "Status": order.STATUS
            });
        }
    
        var excelFilePath = generateExcelFileOrders(jsonDataStruct);
        
        if (fileExists(excelFilePath)) {
            var fileContent = fileReadBinary(excelFilePath);
    
            try {
                fileDelete(excelFilePath);
            } catch (any e) {
                writeOutput("Error deleting file: " & e.message);
                return; 
            }
    
            cfheader(name="Content-Type", value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            cfheader(name="Content-Disposition", value="attachment; filename=sales.xlsx");
            cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable=fileContent);
        } else {
            writeOutput("Error: The specified file does not exist.");
        }
    }
    
    remote string function generateExcelFileOrders(struct data) {
        var spreadsheet = spreadsheetNew("Sales");
        var headers = arguments.data.headers;
        var rowIndex = 1;
    
        if (isArray(headers)) {
            for (var i = 1; i <= arrayLen(headers); i++) {
                spreadsheetSetCellValue(spreadsheet, headers[i], rowIndex, i);
            }
        } else {
            writeOutput("Error: Headers are not an array.");
            return "";
        }
    
        rowIndex = 2;
        for (var row in arguments.data.data) {
            if (isStruct(row)) {
                var colIndex = 1;
                for (var header in headers) {
                    var cellValue = row[header] ?: "";
                    spreadsheetSetCellValue(spreadsheet, cellValue, rowIndex, colIndex);
                    colIndex++;
                }
                rowIndex++;
            } else {
                writeOutput("Error: Row data is not a struct.");
            }
        }
    
        var excelFilePath = expandPath("./sales.xlsx");
        if (fileExists(excelFilePath)) {
            fileDelete(excelFilePath);
        }
        
        spreadsheetWrite(spreadsheet, excelFilePath);
        return excelFilePath;
    }
    
    remote struct function getCategoriesReport() returnformat="JSON" {
        var result = {};

        try {
            var query = new Query();
            query.setDatasource("martDSN"); 
            query.setSQL("SELECT Category, COUNT(ProductName) AS ProductSold FROM Products GROUP BY Category");
            
            var resultSet = query.execute().getResult();

            if (resultSet.recordCount > 0) {
                for (var i = 1; i <= resultSet.recordCount; i++) {
                    var row = resultSet.getRow(i);
                    var categoryName = row.Category;
                    var productSold = row.ProductSold;
                    result[categoryName] = {
                        productSold: productSold
                    }
                }
            }
        } catch (any e) {
            result.error = e.message;
        }

        return result;
    }
    
}