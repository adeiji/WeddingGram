var api_key = '815veNK75NfrlNRIDgguNw';

var mandrill = require('mandrill-api/mandrill');
var mandrill_client = new mandrill.Mandrill(api_key);


exports.sendEmail = function sendEmail (request, response) {

	console.log('Request Received');
	var email = request.body.contactEmailField;
	var name = request.body.contactNameField;
	var message = request.body.contactMessageTextarea;
	//Get an HTML document which is the body of the actual email
	var html = getHTMLDocument(email, name, message);
	//var from_email = 'customercare@smart-two.com';
	var from_email = 'adebayoiji@gmail.com';
	var from_name = 'Dephyned Customer Info Form';
	console.log(request.body);
	var to_email = 'adebayoiji@gmail.com';

	var message = {
		'html' 			: html,
		'subject'		: 'You have a potential client!',
		'from_email' 	: from_email,
		'from_name'		: from_name,
		'to'			: [{
			email 	: to_email,
			name 	: 'Valued Customer',
			type    : 'to'
		}],
		'headers' : {
			'Reply-To'	: from_email
		},
		 "important": false,
	    "track_opens": null,
	    "track_clicks": null,
	    "auto_text": null,
	    "auto_html": null,
	    "inline_css": true,
	    "url_strip_qs": null,
	    "preserve_recipients": null,
	    "view_content_link": null,
	    "tracking_domain": null,
	    "signing_domain": null,
	    "return_path_domain": null,
	    "merge": true
	};

	var async = false;
	var ip_pool = "Main Pool";
	//Time to send at in formation YYYY-MM-DD HH:MM:SS 
	var send_at = new Date()
	send_at.setDate(send_at.getDate() - 100);

	console.log('Time to send :' + send_at);

	mandrill_client.messages.send({"message": message, "async": async, "ip_pool": ip_pool }, 
		function(result) {
	    	console.log(result);
	    	var responseJSON = {
    			status  : 200,	
    			success : 'Updated Successfully'
			}

			response.end(JSON.stringify(responseJSON));
	}, function(e) {
	    // Mandrill returns the error as an object with name and message keys
	    console.log('A mandrill error occurred: ' + e.name + ' - ' + e.message);
	    response.send('Failed to send');
	    response.end();
	    // A mandrill error occurred: Unknown_Subaccount - No subaccount exists with the id 'customer-123'
	});



}

function changeDateToUSA (date)
{
	var delimiter = '/';
	var start = 0;
	var tokens = date.split(delimiter).slice(start);

	console.log(tokens);
	return tokens[0] + '/' + tokens[1] + '/' + tokens[2];
}

//
function getHTMLDocument (email, name, message) {
	var html = '<html>' +	
					'<head>' +
						'<style>' +
    						'body {' +
        					'font-family: "Avenir Next"; }' +
    						'#header {' +
        						'width: 100%;' +
        						'background-color: black; }' +
    						'#header-text {' +
        						'color: white;' +
        						'width: 25%;' +
        						'margin: auto;' +
        						'text-align: center;' +
        						'font-size: 50px; }' +
  							'#content {' +
        						'margin-left: 10%; }' +
    					'</style>' +
					'</head>' +
    				'<body>' +
    					'<div id = "header">' +
    						'<div id = "header-text">' +
        						'Dephyned' +
    						'</div>' +
						'</div>' +
						'<div id = "sub-heading">' +
    						'<h2>You have a potential customer!</h2>' +
    						'<hr>' +
						'</div>' +
						'<div id = "content">' +
    						'<p>Name: ' + name + '</p>' +
    						'<p>Email Address: ' + email + '</p>' +
    						'<p>Message: ' + message + '</p>' +
						'</div>' +
					'</body>' +
				'</html>'	

	return html;
}