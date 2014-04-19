$(document).ready(function  () {

  function sendEmail (fromEmail, message) {
    $.ajax({
        type: "POST",
        url: "https://mandrillapp.com/api/1.0/messages/send.json",
        data: {
          'key': '815veNK75NfrlNRIDgguNw',
          'message': {
            'from_email': 'fromEmail',
            'to': [
                {
                  'email': 'adebayoiji@gmail.com',
                  'name': 'From Dephyned.com',
                  'type': 'to'
                }
              ],
            'autotext': 'true',
            'subject': 'Someone wants to talk to you!',
            'html': '<div>' + message + '</div>' 
          }
        }
    }).done(function(response) {
      alert("Email sent.  Thank you for contact dephyned.com!  We'll get back to you shortly!");
      console.log(response); 
    });
  }  
});
  