function handlebarsFirst(context) {
    $.get('./assets/templates/login.cfm', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-container').html(html);
    });
}

function handlebarsAdmin(context) {
    $.get('./assets/templates/loginAdmin.cfm', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-container').html(html);
    });
}


function handlebarsRegister(context) {
    $.get('./assets/templates/register.cfm', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-container').html(html);
    });
}

function handlebarsForgot(context) {
    $.get('./assets/templates/forgotPassword.cfm', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-container').html(html);
    });
}


function handlebarsUserList(context) {
    $.get('./assets/templates/userList.hbs', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-container').html(html);
    });
}

function handlebarsMessagedown(context) {
    $.get('./assets/templates/messages.hbs', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-p').html(html);
    });
}

function handlebarsMessageUp(context) {
    $.get('./assets/templates/navigation.hbs', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-nav').html(html);
    });
}
//handlebarsMessageUp(context);

function handlebarsProductDetails(context) {
    $.get('./assets/templates/product.hbs', function(templateData) {
        var source = templateData;
        var template = Handlebars.compile(source);
        var html = template(context);
        $('#index-container').html(html);
    });
}

function handlebarsUserProfile(data) {
    $.get('../templates/userProfile.hbs')
        .done(function(templateData) {
            var template = Handlebars.compile(templateData);
            var html = template(data);
            $('#profileContainer').html(html);
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            console.error("Error fetching template:", textStatus, errorThrown);
            $('#profileContainer').html('Error fetching user profile template');
        });
}

