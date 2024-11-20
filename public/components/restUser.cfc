
component rest="true" restpath="users" {
    variables.rawKeyeyB64 = "ViHV9/ImYwwnx8GLevuR4oB8QYST4izOiJzi8CCT+Yc=";
    variables.rawKey = binaryDecode(variables.rawKeyeyB64, "base64" );
    variables.keySpec = createObject("java", "javax.crypto.spec.SecretKeySpec");

    variables.c = {
        "algorithm" = "HS256",
        "generateIssuedAt"= true,
        "generateJti"=true
    }

    remote string function registerUser(
    ) httpmethod="POST" consumes="Application/XML" produces="application/xml" restpath="register"{

        local.result = {};

        local.requestBody = getHttpRequestData().content;
        local.bodyData = xmlParse(local.requestBody);

        local.UserName = local.bodyData.credentials.UserName.xmlText;
        local.UserRole = local.bodyData.credentials.UserRole.xmlText;
        local.Email = local.bodyData.credentials.Email.xmlText;
        local.Password = local.bodyData.credentials.Password.xmlText;

        try {
            if (len(trim(local.UserName)) EQ 0 or len(trim(local.UserRole)) EQ 0 or len(trim(local.Email)) EQ 0 or len(trim(local.Password)) LT 9) {
                restSetResponse({
                    status = 400,
                    headers = { "Content-Type" = "application/xml" },
                    content =   '<response>' &
                                    '<success> false </success>' &
                                    '<message> All fields are required and password must be at least 8 characters long. </message>' &
                                '</response>'
                });
                return;
            }

            // validating email
            if (isDefined("arguments.Email") and not isValid("email", local.Email)) {
                restSetResponse({
                    status = 400,
                    headers = { "Content-Type" = "application/xml" },
                    content =   '<response>
                                    <success> false </success>
                                    <message> Invalid Email Format. </message>
                                </response>'
                });
                return;
            }
    
            //checking duplication of email
            local.emailCheck = queryExecute(
                "SELECT Userid FROM martUsers WHERE Email = :email;",
                { email = local.Email },
                { datasource = "martDSN" }
            );
    
            if (local.emailCheck.recordCount GT 0) {
                restSetResponse({
                    status = 409,
                    headers = { "Content-Type" = "application/xml" },
                    content =   '<response>
                                    <success> false </success>
                                    <message> Email already in use. </message>
                                </response>'
                });
                return;
            }

            local.HashedPassword = hash(local.Password, "SHA-256");
    
            //execution of insert query
            queryExecute(
                "INSERT INTO martUsers (UserName, UserRole, Email, Password) VALUES (:userName, :userRole, :email, :HashedPassword)",
                {
                    userName = local.UserName,
                    userRole = local.UserRole,
                    email = local.Email,
                    password = local.HashedPassword
                },
                { datasource = "martDSN" }
            );
    
            //Getting newly inserted row
            local.newUser = queryExecute(
                "SELECT Userid, UserName, UserRole, Email FROM martUsers WHERE Email = :email;",
                { email = local.Email },
                { datasource = "martDSN" }
            );

            local.responseXml = '<response>
                                    <success> true </success>
                                    <message>User created successfully</message>
                                    <data>
                                        <UserId>' & local.newUser.UserId[1] & '</UserId>
                                        <username>' & local.newUser.UserName[1] & '</username>
                                        <userrole>' & local.newUser.UserRole[1] & '</userrole>
                                        <email>' & local.newUser.Email[1] & '</email>
                                    </data>
                                </response>'
    
            restSetResponse({
                status = 201,
                content = local.responseXml,
                contentType = "application/xml"
            });
    
        } catch (any e) {
            // Log the error message for debugging
            writeDump(var=e, format="html", output="console");
            restSetResponse({
                status = 500,
                headers = { "Content-Type" = "application/xml" },
                content = '<response>' &
                            '<success>false</success>' &
                            '<type>ServerError</type>' &
                            '<message>An unexpected error occurred: ' & e.message & '</message>' &
                          '</response>'
            });
        }
        
    }


    remote string function loginAdmin() httpmethod="POST" restpath="loginAdmin" consumes="Application/XML" produces="application/xml"{
        local.requestBody = getHttpRequestData().content;
        local.bodyData = xmlParse(local.requestBody);
        //writeDump(bodyData); abort;

        local.userName = local.bodyData.credentials.userName.xmlText;
        local.password = local.bodyData.credentials.Password.xmlText;

        

        local.userCheck = queryExecute(
            "SELECT * FROM martUsers WHERE userName = :userName;",
            { userName = local.userName },
            { datasource = "martDSN" }
        );

        if(local.userCheck.recordCount == 1 && local.password != local.userCheck.password){
            restSetResponse({
                status = 401,
                content =   '<response>
                                <success>false</success>
                                <message> Password does not match </message>
                            </response>'
            });
            return;
        }

        if(local.userCheck.recordCount == 1 && local.password == local.userCheck.password){


            local.text = {
                "exp" = DateAdd("n", 30, now())
            }
        
            local.rawKey = binaryDecode(variables.rawKeyeyB64, "base64" );
            local.keySpec = createObject("java", "javax.crypto.spec.SecretKeySpec");
            local.key = local.keySpec.init(local.rawKey, local.userCheck.UserId);
        
            local.c = {
                "algorithm" = "HS256",
                "generateIssuedAt"= true,
                "generateJti"=true
            }
        
            local.createjws = CreateSignedJWT(local.text, local.key, local.c)

            restSetResponse({
                status = 200,
                content =   '<response>
                                <success>true</success>
                                <message> Admin Authenticated successfully. </message>
                                <userId>' & local.userCheck.UserId &'</userId>
                                <username>' & local.userCheck.username &'</username>
                                <userrole>' & local.userCheck.userrole &'</userrole>
                                <email>' & local.userCheck.email &'</email>
                                <token>' & local.createjws & '</token>
                            </response>'
            });

        }else{
            restSetResponse({
                status = 401,
                content =   '<response>
                                <success>false</success>
                                <message> Admin Does not exists. </message>
                            </response>'
            });
        }
    }



    remote string function loginUser() httpmethod="POST" restpath="login" consumes="Application/XML" produces="application/xml"{
        local.requestBody = getHttpRequestData().content;
        local.bodyData = xmlParse(local.requestBody);
        //writeDump(bodyData); abort;   

        local.userName = local.bodyData.credentials.userName.xmlText;
        local.password = local.bodyData.credentials.Password.xmlText;

        

        local.userCheck = queryExecute(
            "SELECT * FROM martUsers WHERE userName = :userName;",
            { userName = local.userName },
            { datasource = "martDSN" }
        );

        if(local.userCheck.recordCount == 1 && local.password != local.userCheck.password){
            restSetResponse({
                status = 401,
                content =   '<response>
                                <success>false</success>
                                <message> Password does not match </message>
                            </response>'
            });
            return;
        }

        if(local.userCheck.recordCount == 1 && local.password == local.userCheck.password){

            local.text = {
                "exp" = DateAdd("n", 30, now())
            }
        
            local.rawKey = binaryDecode(variables.rawKeyeyB64, "base64" );
            local.keySpec = createObject("java", "javax.crypto.spec.SecretKeySpec");
            local.key = local.keySpec.init(local.rawKey, local.userCheck.UserId);
        
            local.c = {
                "algorithm" = "HS256",
                "generateIssuedAt"= true,
                "generateJti"=true
            }
        
            local.createjws = CreateSignedJWT(local.text, local.key, local.c)

            restSetResponse({
                status = 200,
                content =   '<response>
                                <success>true</success>
                                <message> User Authenticated successfully. </message>
                                <userId>' & local.userCheck.UserId &'</userId>
                                <username>' & local.userCheck.username &'</username>
                                <userrole>' & local.userCheck.userrole &'</userrole>
                                <email>' & local.userCheck.email &'</email>
                                <token>' & local.createjws & '</token>
                            </response>'
            });

        }else{
            restSetResponse({
                status = 401,
                content =   '<response>
                                <success>false</success>
                                <message> User Does not exists. </message>
                            </response>'
            });
        }
    }

    remote string function RestsendPasswordResetEmail() {
        local.requestBody = getHttpRequestData().content;
        local.bodyData = xmlParse(local.requestBody);

        local.email = local.bodyData.credentials.email.xmlText;

        local.resetLink = "public\assets\templates\passwordReset.hbs";

        // Prepare the email content
        local.content = "<html>" &
                        "<body>" &
                        "<h1>Password Reset Request</h1>" &
                        "<p>Hi there,</p>" &
                        "<p>We received a request to reset your password. Click the link below to reset it:</p>" &
                        "<p><a href='" & local.resetLink & "'>Reset Password</a></p>" &
                        "<p>If you did not request this, please ignore this email.</p>" &
                        "<p>Thanks!</p>" &
                        "</body>" &
                        "</html>";

        // Set up mail parameters
        local.mailParams = {
            to = local.email,
            from = "dineshkumarreddyh@gmail.com",
            subject = "Password Reset Request",
            type = "html",
            server = "smtp-relay.brevo.com",
            port = 587,
            username = "7bf212002@smtp-brevo.com",
            password = "mBdRbqz0D8Zp5fgL",
            body = local.content
        };

        // Create and send the mail
        local.mail = new mail(local.mailParams);

        // Return a success message
        return "Password reset email sent successfully to: " & local.email;
    }

    remote string function getuser(
        required numeric userId restargsource="Path",
        required string token restargsource="header"
    ) httpmethod="GET" restpath="{userId}" produces="application/xml"{
        local.result = {};
        local.queryResult = {};

        // Validate the token
        if (not this.validateToken(token, {"argType": "userId", "arg": userId})) {
            restSetResponse({
                status = 403,
                headers = { "Content-Type" = "application/xml" },
                content = '<response>' &
                            '<success> false </success>' &
                            '<message> Forbidden: Invalid Token. </message>' &
                          '</response>'
            });
            return;
        }

        try {
            if (not isNumeric(userId) or userId LT 1) {
                restSetResponse({
                    status = 400,
                    headers = { "Content-Type" = "application/xml" },
                    content =   '<response>' &
                                    '<success> false </success>' &
                                    '<message> Invalid User ID. </message>' &
                                '</response>'
                });
                return;
            }
        
            // Query the database for user information
            local.queryResult = queryExecute(
                "SELECT UserID, UserName, UserRole, Email FROM martUsers WHERE UserID = :userId;",
                {userId = userId},
                {datasource = "martDSN"}
            );
        
            // If user not found in the database
            if (local.queryResult.recordCount EQ 0) {
                restSetResponse({
                    status = 404,
                    headers = { "Content-Type" = "application/xml" },
                    content =   '<response>' &
                                    '<success> false </success>' &
                                    '<message> User Not Found. </message>' &
                                '</response>'
                });
                return;
            }

            local.responseXml = '<response>' &
                                    '<success> true </success>' &
                                    '<data>'&
                                        '<userid>' & local.queryResult.UserID[1] & '</userid>' &
                                        '<username>' & local.queryResult.UserName[1] & '</username>' &
                                        '<userrole>' & local.queryResult.UserRole[1] & '</userrole>' &
                                        '<email>' & local.queryResult.Email[1] & '</email>' &
                                    '</data>'&
                                '</response>';

            //returns 200 OK on user found
            restSetResponse({
                status = 200,
                headers = { "Content-Type" = "application/xml" },
                content = local.responseXml
            });
            return;
        
        } catch (any e) {

            restSetResponse({
                status = 500,
                headers = { "Content-Type" = "application/xml" },
                content =   '<response>
                                <success> true </success>
                                <type> ServerError </type>
                                <message> An unexpected error occurred: ' & e.message & '</message>
                            </response>'
            });
            return;
        }
    }


    public boolean function validateToken(
        required string token,
        required struct encodeValues) {
        try{
            
            if(encodeValues.argType == "userid"){
                local.key = variables.keySpec.init(variables.rawKey, encodeValues.arg);
            }
            if(encodeValues.argType == "username"){
                local.key = variables.keySpec.init(variables.rawKey, encodeValues.arg);
            }

            local.jwtVerification = VerifySignedJWT(arguments.token, local.key, variables.c);
            return local.jwtVerification.valid;

        }catch (any e) {
            return false;
        }
    }


}