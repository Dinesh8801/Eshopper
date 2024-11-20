let sessionToken = "";
let sessionUserId = null;
let sessionUserName = null;
let sessionUserRole = null;
let sessionUserEmail = null;
let sessionPassword = null;


function AdminLogin(userinfo) {
    var xmlData = `
        <credentials>
            <UserName>${userinfo.username}</UserName>
            <Password>${userinfo.password}</Password>
        </credentials>`;

    $.ajax({    
        type: 'POST',
        url: 'http://localhost:8500/rest/martapi12/users/loginAdmin',
        contentType: 'application/xml',
        dataType: 'xml',
        data: xmlData,
        success: function(response) {
            let success = $(response).find('success').text().trim();
            sessionUserName = $(response).find('username').text().trim();
            sessionPassword = $(response).find('password').text().trim();
            

            if (success === 'true') {
                console.log("Admin Logged in successfully:", response);
                sessionToken = $(response).find('token').text().trim();
                sessionUserId = $(response).find('userId').text().trim();

                console.log(userinfo);
                
                
                    getUserdetails({
                        token: sessionToken,
                        id: sessionUserId
                    }).then(users => {
                        if ($(users).find('success').text().trim() == "true") {
                            handlebarsUserList({
                                "username": $(users).find('username').text().trim(),
                                "role": $(users).find('role').text().trim(),
                                "email": $(users).find('email').text().trim(),
                            });
                        }
                    }).catch(error => {
                        console.error("Error fetching user details:", error);
                    });
                    
            } else {
                console.log("Error in user creation:", response);
            }
            document.getElementById('index-p').style.display = 'none';
        },
        error: function(xhr, status, error) {
            document.getElementById('index-p').style.display = 'block';
            handlebarsMessagedown({
                "message": $(xhr.responseText).find('message').text()
            });
        }
    });
}




function userLogin(userinfo) {
    var xmlData = `
        <credentials>
            <UserName>${userinfo.username}</UserName>
            <Password>${userinfo.password}</Password>
        </credentials>`;

    $.ajax({
        type: 'POST',
        url: 'http://localhost:8500/rest/martapi12/users/login',
        contentType: 'application/xml',
        dataType: 'xml',
        data: xmlData,
        success: function(response) {
            let success = $(response).find('success').text().trim();
            sessionUserName = $(response).find('username').text().trim();
            sessionPassword = $(response).find('password').text().trim();
            

            if (success === 'true') {
                console.log("User Logged in successfully:", response);
                sessionToken = $(response).find('token').text().trim();
                sessionUserId = $(response).find('userId').text().trim();


                getDashboard();
                
                    
            } else {
                console.log("Error in user creation:", response);
            }
            document.getElementById('index-p').style.display = 'none';
        },
        error: function(xhr, status, error) {
            document.getElementById('index-p').style.display = 'block';
            handlebarsMessagedown({
                "message": $(xhr.responseText).find('message').text()
            });
        }
    });
}

function getDashboard() {
    window.location.href = "../public/assets/templates/dashboard.cfm";
}


function userRegistration(userinfo) {
    var xmlData = `
        <credentials>
            <UserName>${userinfo.username}</UserName>
            <UserRole>${userinfo.userrole}</UserRole>
            <Email>${userinfo.email}</Email>
            <Password>${userinfo.password}</Password>
        </credentials>`;
        console.log(userinfo.email);

    $.ajax({
        type: 'POST',
        url: 'http://localhost:8500/rest/martapi12/users/register',
        contentType: 'application/xml',
        dataType: 'xml',
        data: xmlData,
        success: function(response) {
            let success = $(response).find('success').text().trim();

            if (success === 'true') {
                console.log("User created successfully:", response);
                window.location = 'index.cfm';
            } else {
                console.log("Error in user creation:", response);
            }
            document.getElementById('index-p').style.display = 'none';
        },
        error: function(xhr, status, error) {
            document.getElementById('index-p').style.display = 'block';
            handlebarsMessagedown({
                "message": $(xhr.responseText).find('message').text()
            })
        }
    });
}
