
component {

	remote function getCategories() returnformat="JSON" {
		var result = [];
		
		try {
			var query = new Query();
			query.setDatasource("martDSN");
			query.setSQL("SELECT DISTINCT Category FROM Products");
			
			var resultSet = query.execute().getResult();
			
			if (resultSet.recordCount > 0) {
				for (var i = 1; i <= resultSet.recordCount; i++) {
					result.append(resultSet.getRow(i).Category);
				}
			}
		} catch (any e) {
			result = ["Error: " & e.message];
		}
	
		return result;
	}
	

	remote struct function getProductsByCategory(categories=[]) returnformat="JSON" {
		var result = {};
	
		try {
			if (isJSON(arguments.categories)) {
				categories = deserializeJSON(arguments.categories);
			} else {
				categories = [];
			}
	
			var query = new Query();
			query.setDatasource("martDSN");
	
			var sql = "SELECT ProductID, ProductName, Category, Price, ProductPath FROM Products";
	
			if (arrayLen(categories) > 0) {
				sql &= " WHERE Category IN (" & listQualify(arrayToList(categories), "'", ",") & ")";
			}
	
			query.setSQL(sql);
	
			var resultSet = query.execute().getResult();
	
			if (resultSet.recordCount > 0) {
				for (var i = 1; i <= resultSet.recordCount; i++) {
					var row = resultSet.getRow(i);
					var productId = row.ProductID;
					var productName = row.ProductName;
					var category = row.Category;
					var price = row.Price;
					var productPath = row.ProductPath;
	
					if (!structKeyExists(result, category)) {
						result[category] = {};
					}
	
					result[category][productName] = {
						PRODUCTID: productId,
						PRODUCTNAME: productName,
						CATEGORYNAME: category,
						PRICE: price,
						PRODUCTPATH: productPath
					};
				}
			}
		} catch (any e) {
			result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
		}
	
		return result;
	}
	
		remote struct function getCategoriesForAjax() returnformat="JSON" {
			var result = {};
	
			try {
				var query = new Query();
				query.setDatasource("martDSN"); 
				query.setSQL("SELECT Category FROM Products");
				
				var resultSet = query.execute().getResult();
	
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var categoryName = row.Category;
	
						result[categoryName] = categoryName;
					}
				}
			} catch (any e) {
				result.error = e.message;
			}
	
			return result;
		}

		remote struct function getProductsForAjax() returnformat="JSON" {
			var result = {};
		
			try {
				var query = new Query();
				query.setDatasource("martDSN"); 
				query.setSQL("SELECT ProductID, ProductName, Category, Price, ProductPath FROM Products");
		
				var resultSet = query.execute().getResult();
		
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var productId = row.productId;
						var productName = row.ProductName;
						var categoryName = row.Category;
						var price = row.Price;
						var productPath = row.ProductPath;
		
						if (!structKeyExists(result, categoryName)) {
							result[categoryName] = {};
						}
		
						result[categoryName][productName] = {
							productId: productId,
							categoryName: categoryName,
							productName: productName,
							price: price,
							productPath: productPath
						};
					}
				}
			} catch (any e) {
				result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
			}
		
			return result;
		}

		remote struct function getWatchProducts() returnformat="JSON" {
			var result = {};
		
			try {
				var query = new Query();
				query.setDatasource("martDSN"); 
				query.setSQL("SELECT ProductID, ProductName, Category, Price, ProductPath FROM Products WHERE Category = 'watch'");
		
				var resultSet = query.execute().getResult();
		
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var productId = row.productId;
						var productName = row.ProductName;
						var categoryName = row.Category;
						var price = row.Price;
						var productPath = row.ProductPath;
		
						if (!structKeyExists(result, categoryName)) {
							result[categoryName] = {};
						}
		
						result[categoryName][productName] = {
							productId: productId,
							categoryName: categoryName,
							productName: productName,
							price: price,
							productPath: productPath
						};
					}
				}
			} catch (any e) {
				result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
			}
		
			return result;
		}

		remote struct function getCameraProducts() returnformat="JSON" {
			var result = {};
		
			try {
				var query = new Query();
				query.setDatasource("martDSN"); 
				query.setSQL("SELECT ProductID, ProductName, Category, Price, ProductPath FROM Products WHERE Category = 'camera'");
		
				var resultSet = query.execute().getResult();
		
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var productId = row.productId;
						var productName = row.ProductName;
						var categoryName = row.Category;
						var price = row.Price;
						var productPath = row.ProductPath;
		
						if (!structKeyExists(result, categoryName)) {
							result[categoryName] = {};
						}
		
						result[categoryName][productName] = {
							productId: productId,
							categoryName: categoryName,
							productName: productName,
							price: price,
							productPath: productPath
						};
					}
				}
			} catch (any e) {
				result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
			}
		
			return result;
		}

		remote struct function getDroneProducts() returnformat="JSON" {
			var result = {};
		
			try {
				var query = new Query();
				query.setDatasource("martDSN"); 
				query.setSQL("SELECT ProductID, ProductName, Category, Price, ProductPath FROM Products WHERE Category = 'drone'");
		
				var resultSet = query.execute().getResult();
		
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var productId = row.productId;
						var productName = row.ProductName;
						var categoryName = row.Category;
						var price = row.Price;
						var productPath = row.ProductPath;
		
						if (!structKeyExists(result, categoryName)) {
							result[categoryName] = {};
						}
		
						result[categoryName][productName] = {
							productId: productId,
							categoryName: categoryName,
							productName: productName,
							price: price,
							productPath: productPath
						};
					}
				}
			} catch (any e) {
				result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
			}
		
			return result;
		}

		remote struct function getMobileProducts() returnformat="JSON" {
			var result = {};
		
			try {
				var query = new Query();
				query.setDatasource("martDSN"); 
				query.setSQL("SELECT ProductID, ProductName, Category, Price, ProductPath FROM Products WHERE Category = 'mobile'");
		
				var resultSet = query.execute().getResult();
		
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var productId = row.productId;
						var productName = row.ProductName;
						var categoryName = row.Category;
						var price = row.Price;
						var productPath = row.ProductPath;
		
						if (!structKeyExists(result, categoryName)) {
							result[categoryName] = {};
						}
		
						result[categoryName][productName] = {
							productId: productId,
							categoryName: categoryName,
							productName: productName,
							price: price,
							productPath: productPath
						};
					}
				}
			} catch (any e) {
				result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
			}
		
			return result;
		}

		remote struct function getOrdersForAjax(required numeric months) returnformat="JSON" {
			var result = {};
			var userId = session.sessionId;
			var dateFilter = dateAdd("m", -months, now());
			try {
				var query = new Query();
				query.setDatasource("martDSN");
				query.setSQL("SELECT SaleID, CustomerID, SaleDate, ProductID, ProductName, Quantity, Price, TotalAmount, Status FROM Sales WHERE customerID = :userId AND SaleDate >= :dateFilter");
				query.addParam(name="userId", value=userId, cfsqltype="cf_sql_integer");
				query.addParam(name="dateFilter", value=dateFilter, cfsqltype="cf_sql_date");
				var resultSet = query.execute().getResult();
		
				if (resultSet.recordCount > 0) {
					for (var i = 1; i <= resultSet.recordCount; i++) {
						var row = resultSet.getRow(i);
						var saleId = row.saleId;
						var customerId = row.customerId;
						var saleDate = row.saleDate;
						var productId = row.productId;
						var productName = row.productName;
						var quantity = row.quantity;
						var price = row.price;
						var totalAmount = row.totalAmount;
						var status = row.status;
		
						if (!structKeyExists(result, saleId)) {
							result[saleId] = {};
						}
		
						result[saleId] = {
							customerId: customerId,
							saleDate: saleDate,
							productId: productId,
							productName: productName,
							quantity: quantity,
							price: price,
							totalAmount: totalAmount,
							status: status
						};
					}
				}
			} catch (any e) {
				result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
			}
		
			return result;
		}
	
		remote struct function addToCart(required string productId, required string productName, required numeric price, required numeric quantity, required string productpath) returnformat="JSON" {
			var result = {};
		
			if (not StructKeyExists(session, "userId")) {
				result.message = "User not logged in.";
				return result;
			}
		
			try {
				cflock(scope="session", type="exclusive", timeout="5") {
					var itemFound = false;
		
					for (var i = 1; i <= ArrayLen(session.cart); i++) {
						if (session.cart[i].product_id == productId) {
							session.cart[i].quantity += quantity;
							itemFound = true;
							break;
						}
					}
		
					if (!itemFound) {
						var sItem = {
							product_id: productId,
							product: productName,
							price: price,
							quantity: quantity,
							productpath: productpath
						};
						ArrayAppend(session.cart, sItem);
					}
				}
		
				result.success = true;
				result.message = "Item added to cart successfully.";
			} catch (any e) {
				result.message = "Error adding item to cart: " & e.message;
			}
		
			return result;
		}
		
		
		
		remote array function getCartItems() returnformat="JSON" {
			if (not StructKeyExists(session, "cart")) {
				return [];
			}
			return session.cart;
		}
		
		remote void function removeFromCart(required string productId) {
			if (not StructKeyExists(session, "userId")) {
				throw(type="Unauthorized", message="User not logged in.");
			}
		
			if (not StructKeyExists(session, "cart")) {
				return;
			}
		
			for (var i = ArrayLen(session.cart); i >= 1; i--) {
				if (session.cart[i].product_id == productId) {
					ArrayDeleteAt(session.cart, i);
					break;
				}
			}
		}

		remote string function getSessionId() returnformat="JSON" {
			return session.sessionId;
		}        

		remote struct function applyCoupon(required string couponCode) returnformat="JSON" {
			var result = {};

			getCoupon = queryExecute("
				SELECT couponCode, discount
				FROM coupons
				WHERE couponCode = :couponCode", 
				{ couponCode = arguments.couponCode }, 
				{ datasource = "martDSN" });

			if (getCoupon.recordCount EQ 1) {
				result.SUCCESS = true;
				result.DISCOUNT = getCoupon.discount;
				result.MESSAGE = "Coupon applied successfully!";
			} else {
				result.SUCCESS = false;
				result.MESSAGE = "Invalid coupon code";
			}

			return result;
		}
		
		remote struct function placeOrder(required numeric customerId, required numeric totalAmount) returnformat="JSON" {
			var result = {};
			var saleId = 0;
		
			try {
				if (StructKeyExists(session, "cart") && ArrayLen(session.cart) > 0) {
					var invoiceDetails = "";
					var orderDetails = [];
		
					for (var item in session.cart) {
						try {
							invoiceDetails &= "Product: " & item.PRODUCT & ", Price: " & item.PRICE & ", Quantity: " & item.QUANTITY & "<br>";
							var pkkey = queryExecute(
								"INSERT INTO Sales (CustomerID, ProductID, ProductName, Quantity, Price, TotalAmount, Status) VALUES (:customerId, :productId, :productName ,:quantity, :price, :totalAmount, 'Packaging')",
								{
									customerId = arguments.customerId,
									productId = item.PRODUCT_ID,
									productName = item.PRODUCT,
									quantity = item.QUANTITY,
									price = item.PRICE,
									totalAmount = arguments.totalAmount
								},
								{ datasource = "martDSN" }
							);

							try {
								queryExecute(
								"UPDATE Products SET StockQuantity = StockQuantity - :quantity WHERE ProductID = :productId AND StockQuantity >= :quantity",
								{
									quantity = item.QUANTITY,
									productId = item.PRODUCT_ID
								},
								{ datasource = "martDSN" }
							);
							} catch (any e) {
								result.success = false;
								result.message = "Product Out of Stock" & e.message;
								return result;
							}
							

							//writeDump(pkkey.generatedKey);
		
							arrayAppend(orderDetails, {
								PRODUCTID: item.PRODUCT_ID,
								PRODUCTNAME: item.PRODUCT,
								QUANTITY: item.QUANTITY,
								PRICE: item.PRICE,
								TOTALAMOUNT: arguments.totalAmount
							});
						} catch (any e) {
							writeDump("Error inserting SaleItem for ProductID " & item.PRODUCT_ID & ": " & e.message);
							result.success = false;
							result.message = "Error inserting SaleItem: " & e.message;
							return result;
						}
					}
		
					var pdfFilePath = expandPath("../sales/SaleReceipt_" & customerId & "_" & totalAmount & ".pdf");
					var htmlContent = "<h1>e-Shopper</h1>";
					htmlContent &= "<h3>Thanks For Shopping Sale Receipt</h3>";
					htmlContent &= "<p>Customer ID: " & arguments.customerId & "</p>";
					htmlContent &= "<p>Order Date: " & now() & "</p>";
					htmlContent &= "<table border='1' style='width: 100%; border-collapse: collapse;'>";
					htmlContent &= "<tr><th>Product ID</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Total Amount</th></tr>";
		
					for (var detail in orderDetails) {
						htmlContent &= "<tr>";
						htmlContent &= "<td>" & detail.PRODUCTID & "</td>";
						htmlContent &= "<td>" & detail.PRODUCTNAME & "</td>";
						htmlContent &= "<td>" & detail.QUANTITY & "</td>";
						htmlContent &= "<td>" & detail.PRICE & "</td>";
						htmlContent &= "<td>" & detail.TOTALAMOUNT & "</td>";
						htmlContent &= "</tr>";
					}
					htmlContent &= "</table>";
		
					cfdocument(
						filename=pdfFilePath,
						format="pdf",
						pagetype="letter",
						overwrite="true"
					) {
						writeOutput(htmlContent);
					}
		
					var emailSubject = "e-Shopper Order Invoice";
					var emailBody = "<h1>Invoice Details</h1><p>Thank you for your order!</p><p>Invoice:</p><br>" & invoiceDetails & "<p>Total Amount: " & totalAmount & "</p>";
					var emailTo = session.email;
					try {
						cfmail(
							to=emailTo,
							from = "workprofiledinesh@gmail.com",
								subject = "Registration Successfull with e-Shopper.",
								server = "smtp.gmail.com",
								port = "465",
								username = "workprofiledinesh@gmail.com",
								password = "urra fqcv smlu chym",
								type = "html",
								useSSL = "true"
							)
						{
							writeOutput(emailBody);
						};
					} catch (any e) {
						result.success = false;
						result.message = "Error sending email: " & e.message;
						return result;
					}
				} else {
					result.success = false;
					result.message = "No items in the cart.";
					return result;
				}
				
				session.cart = [];

				result.success = true;
				result.message = "Order placed successfully, invoice generated, and sent!";
			} catch (any e) {
				result.success = false;
				result.message = "Error placing order: " & e.message;
			}
		
			return result;
		}
		
		
		remote void function exportOrdersToExcel() {
		   var jsonDataStruct = {};
		   var ordersData = getOrdersForAjax();
		
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
		
			for (key in ordersData) {
				var order = ordersData[key];
		
				arrayAppend(jsonDataStruct.data, {
					"Order ID": key,
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
		
			var excelFilePath = generateExcelFile(jsonDataStruct);
			if (fileExists(excelFilePath)) {
				fileContent = fileReadBinary(excelFilePath);
				
				try {
					fileDelete(excelFilePath);
				} catch (any e) {
					writeOutput("Error deleting file: " & e.message);
					return;
				}
			
				cfheader(name="Content-Type", value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				cfheader(name="Content-Disposition", value="attachment; filename=orders.xlsx");
				cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable=fileContent);
			} else {
				writeOutput("Error: The specified file does not exist.");
			}
			
		   }

		   remote string function generateExcelFile(struct data) {
			var spreadsheet = spreadsheetNew("Orders");
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
		
			var excelFilePath = expandPath("./orders_" & dateFormat(now(), "yyyymmdd") & ".xlsx");
		
			if (fileExists(excelFilePath)) {
				fileDelete(excelFilePath);
			}
		
			spreadsheetWrite(spreadsheet, excelFilePath);
			return excelFilePath;
		}
		
		
	}
		