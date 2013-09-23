var GCM = require('gcm').GCM;

var apiKey = '';
var gcm = new GCM(apiKey);

var message = {
    registration_id: 'APA91bHdgYsUDH36GMDPqytPFGQdAZZYKru52fPuFsoSz82f05qAcptaYPAu79mFoe1-2kIBeLaxFH7mB9ezUgdZjjiwCjIxSOu3jv8teKJLHMnCH7t5Ii9FmHodF-jfm7ZZO_GlE1T-jbZsU6-4Xbi6JeU3a8eky4XRy6sV7pjoAxFG2qSHTRY', // required
    collapse_key: 'Collapse key',
    data : {
        'message': '\u270C Peace, Love \u2764 and PhoneGap \u2706!',
        'title': 'Push Notification Sample',
        'msgcnt': '3',
        'soundname':'beep.wav'
    }
};

gcm.send(message, function(err, messageId){
    if (err) {
        console.log("Something has gone wrong!", err);
    } else {
        console.log("Sent with message ID: ", messageId);
    }
});
