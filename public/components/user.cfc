component {
	remote string function registerUser() returnformat="JSON" {
		
		var body = deserializeJSON(getHttpRequestData().content);
		local.firstName = body.firstName;
		local.lastName = body.lastName;
		local.username = body.userName;
		local.email = body.email;
		local.password = body.password;
		local.hashedPassword = hash(local.password, "SHA-256");
		local.address = body.address;
		local.country = body.country;
		local.state = body.state;
		local.zip = body.zip;
		result = {};

		if (len(trim(local.firstName)) EQ 0) {
			return serializeJSON({
				success = false,
				message = "Firstname is mandatory."
			});
		}
		if (len(trim(local.lastName)) EQ 0) {
		return serializeJSON({
				success = false,
				message = "Lastname is mandatory."
			});
		}
		if (len(trim(local.UserName)) EQ 0) {
			return serializeJSON({
					success = false,
					message = "Username is mandatory."
			});
		}
		if (len(trim(local.Password)) EQ 0) {
			return serializeJSON({
					success = false,
					message = "Password is mandatory."
			});
		}
		if (len(trim(local.Password)) LT 9) {
			return serializeJSON({
					success = false,
					message = "Password must be more than 8 chracters."
			});
		}
		if (len(trim(local.Email)) EQ 0) {
			return serializeJSON({
					success = false,
					message = "Email is mandatory."
			});
		}
		if (!isValid("email", local.Email)) {
			return serializeJSON({
				success = false,
				message = "Invalid email format."
			});
		}
		if (NOT REFindNoCase("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$", local.Email)) {
			result.success = false;
			result.message = "Invalid email format provide domain.";
			return result;
		}
		if (len(trim(local.zip)) EQ 0) {
			return serializeJSON({
				success = false,
				message = "Zip is mandatory."
			});
		}
		if (!len(trim(local.zip)) EQ 6) {
			return serializeJSON({
				success = false,
				message = "Invalid Zip Code."
			});
		}
	
		try {
			var existingUserCheck = queryExecute(
				"SELECT UserID FROM martUsers WHERE UserName = :username OR Email = :email",
				{
					username = local.username,
					email = local.email
				},
				{ datasource = "martDSN" }
			);
	
			if (existingUserCheck.recordCount > 0) {
				return serializeJSON({
					success = false,
					message = "Username or email already exists."
				});
			}
	
			queryExecute(
				"INSERT INTO martUsers (FirstName, LastName, UserName, Email, Password, Address, Country, State, Zip, UserRole) VALUES (:firstName, :lastName, :username, :email, :password, :address, :country, :state, :zip, 'user')",
				{
					firstName = local.firstName,
					lastName = local.lastName,
					username = local.username,
					email = local.email,
					password = local.hashedPassword,
					address = local.address,
					country = local.country,
					state = local.state,
					zip = local.zip
				},
				{ datasource = "martDSN" }
			);


			emailBody = "
							<html>
								<body>
									<p>Dear User,</p>
									<p>Congratulations! Your registration with e-Shopper has been successfully completed.</p>
									<p>You can now log in to your account using the credentials you provided during registration.</p>
									<p>If you have any questions or need assistance, please feel free to contact our support team.</p>
									<p>Welcome aboard, and happy shopping!</p>
									<p>Regards,<br>e-Shopper Team</p>
								</body>
							</html>
							";
							cfmail(
								to = local.email,
								from = "workprofiledinesh@gmail.com",
								subject = "Registration Successfull with e-Shopper.",
								server = "smtp.gmail.com",
								port = "465",
								username = "workprofiledinesh@gmail.com",
								password = "urra fqcv smlu chym",
								type = "html",
								useSSL = "true"
							) {
								writeOutput(emailBody);
							};
	
			return serializeJSON({
				success = true,
				message = "User registered successfully and e-mail sent."
			});
	
		} catch (any e) {
			return serializeJSON({
				success = false,
				message = "An unexpected error occurred: " & e.message
			});
		}
	}
	

	remote string function loginForAjax(string username, string password) returnformat="JSON" {
		
		local.username = arguments.username;
		local.password = arguments.password;
		local.HashedPassword = hash(local.Password, "SHA-256");

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

		if (userCheck.recordCount == 1 && HashedPassword != userCheck.password) {
			return serializeJSON({
				success = false,
				message = "Password does not match."
			});
		}

		if (userCheck.recordCount == 1 && HashedPassword == userCheck.password) {
			session.isLoggedIn = true;
			session.sessionId = userCheck.UserId;
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

	remote string function sendPasswordResetEmail(string email) returnformat="JSON" {
		if (not structKeyExists(arguments, "email") or trim(arguments.email) == "") {
			return serializeJSON({
				success = false,
				message = "Email parameter is required."
			});
		}

		if (NOT REFindNoCase("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$", arguments.email)) {
			result.success = false;
			result.message = "Invalid email format.";
			return result;
		}

		local.email = arguments.email;
		
		
		local.resetLink = "http://localhost:8500/Assignments/Eshopper/public/assets/templates/passwordReset.cfm";

		local.content = "<html>" &
			"<body>" &
			"<h1>E-Shopper Password Reset Request</h1>" &
			"<p>Hi there,</p>" &
			"<p>We received a request to reset your password. Click the link below to reset it:</p>" &
			"<p><a href='" & local.resetLink & "'>Reset Password</a></p>" &
			"<p>If you did not request this, please ignore this email.</p>" &
			"<p>Thanks team e-Shopper!</p>" &
			"</body>" &
			"</html>";
	
			try {
				cfmail(
					to =local.email,
					from = "workprofiledinesh@gmail.com",
					subject = "Password Reset Mail from e-Shopper.",
					server = "smtp.gmail.com",
					port = "465",
					username = "workprofiledinesh@gmail.com",
					password = "urra fqcv smlu chym",
					type = "html",
					useSSL = "true"
				) {
					writeOutput(local.content);
				};

				return serializeJSON({
					success = true,
					message = "Password reset email sent successfully.",
					mail: local.email
				});
			} catch (any e) {
				return serializeJSON({
					success = false,
					message = "Error sending email: " & e.message,
					mail: local.email
				});
			}

	}

	remote struct function logoutUser() returnformat="JSON"{
		try{
			sessionInvalidate();
			response.message="Logged out successfully";
			response.success=true;
		}
		catch (any e) {
			response.message=e.message;  
		}
		return response;
	}
	
	remote function getUserById(required numeric userId) returnformat="json" output="false" {
		var result = {};
		var qUser = {};

		qUser = queryExecute(
			"SELECT UserName, Password, Email, UserRole FROM martUsers WHERE UserID = :userId",
			{ userId = userId },
			{ datasource = "martDSN" }
		);

		if (qUser.recordCount EQ 1) {
			result = qUser.toArray();
		}

		return result;
	}

	remote struct function getUserBySession() returnformat="JSON" {
		var result = {};
		var userId = session.sessionId;
		try {
			var query = new Query();
			query.setDatasource("martDSN");
			query.setSQL("SELECT UserID, FirstName, LastName, UserName, Password, Email, Address, Country, State, Zip FROM martUsers WHERE UserID = :userId");
			query.addParam(name="userId", value=userId, cfsqltype="cf_sql_integer");
			var resultSet = query.execute().getResult();

			if(resultSet.recordCount > 0) {
				for(var i=1; i<= resultSet.recordCount; i++) {
					var row = resultSet.getRow(i);
					var userId = row.UserID;
					var firstName = row.FirstName;
					var lastName = row.LastName;
					var userName = row.UserName;
					var password = row.Password;
					var email = row.Email;
					var address = row.Address;
					var country = row.Country;
					var state = row.State;
					var zip = row.Zip;

					if (!structKeyExists(result, userId)) {
						result[userId] = {};
					}
	
					result[userId] = {
						firstName: firstName,
						lastName: lastName,
						userName: userName,
						password: password,
						email: email,
						address: address,
						country: country,
						state: state,
						zip: zip
					};
				}
			}
		} catch (any e) {
			result.error = "Error: " & e.message & " | StackTrace: " & e.stackTrace;
		}
		return result;
	}

	remote struct function updatePasswordReset(string username, string newPassword) returnformat="JSON" {
		var result = {};
	
		try {
			queryExecute(
				"UPDATE martUsers SET Password = :password WHERE UserName = :userName",
				{
					password = hash(arguments.newPassword, "SHA-256"),
					userName = arguments.username
				},
				{ datasource = "martDSN" }
			);
	
			result.SUCCESS = true;
			result.MESSAGE = "Password has been reset successfully!";
		} catch (any e) {
			result.SUCCESS = false;
			result.MESSAGE = "Database error: " & e.message;
		}
	
		return result;
	}

	remote void function generateInvoice(string orderId) {

		var orderDetails = getOrderDetailsById(orderId);
		
		if (!structKeyExists(orderDetails, orderId)) {
			throw(type="application", message="Order not found.");
		}
	
		var htmlContent = "";

		for(key in orderDetails) {
			var order = orderDetails[key];
			htmlContent &= "<h1>e-Shopper</h1>";
		htmlContent &= "<h3>Invoice for Order ID: " & key & "</h3>";
		htmlContent &= "<p>Customer ID: " & order.CUSTOMERID & "</p>";
		htmlContent &= "<p>Order Date: " & order.SALEDATE & "</p>";
		htmlContent &= "<p>Status: " & order.STATUS & "</p>";

		htmlContent &= "<table border='1' style='width: 100%; border-collapse: collapse;'>";
		htmlContent &= "<tr><th>Product ID</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Total Amount</th></tr>";
		
		htmlContent &= "<tr>";
		htmlContent &= "<td>" & order.PRODUCTID & "</td>";
		htmlContent &= "<td>" & order.PRODUCTNAME & "</td>";
		htmlContent &= "<td>" & order.QUANTITY & "</td>";
		htmlContent &= "<td>" & order.PRICE & "</td>";
		htmlContent &= "<td>" & order.TOTALAMOUNT & "</td>";
		htmlContent &= "</tr>";
	
		htmlContent &= "</table>";
		}

		var pdfFilePath = expandPath("../invoice/invoice_" & orderId & ".pdf");

		cfdocument(
			filename=pdfFilePath,
			format="pdf",
			pagetype="letter",
			overwrite="true"
		) {
			writeOutput(htmlContent);
		}
	
		cfheader(name="Content-Type", value="application/pdf");
		cfheader(name="Content-Disposition", value="attachment; filename=invoice_" & orderId & ".pdf");
		cfcontent(type="application/pdf", file=pdfFilePath);
	}
	


	remote struct function getOrderDetailsById(required numeric orderId) returnformat="json" {
		var result = {};
		
		var qOrder = queryExecute(
			"SELECT SALEID, CUSTOMERID, SALEDATE, PRODUCTID, PRODUCTNAME, QUANTITY, PRICE, TOTALAMOUNT, STATUS " &
			"FROM Sales WHERE SaleID = :orderId",
			{ orderId = orderId },
			{ datasource = "martDSN" }
		);
	
		if (qOrder.recordCount > 0) {
			for (var i = 1; i <= qOrder.recordCount; i++) {
				var row = qOrder.getRow(i);
				var saleId = row.SALEID; 
				var customerId = row.CUSTOMERID;
				var saleDate = row.SALEDATE;
				var productId = row.PRODUCTID;
				var productName = row.PRODUCTNAME;
				var quantity = row.QUANTITY;
				var price = row.PRICE;
				var totalAmount = row.TOTALAMOUNT;
				var status = row.STATUS;
 
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
	
		return result;
	}
	
}
