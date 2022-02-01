var nodemailer = require('nodemailer');

var pw = process.argv[2]
var email = process.argv[3]
var lint = process.argv[4] == 0 ? "Success" : "Failure"
var cypress = process.argv[5] == 0 ? "Success" : "Failure"
var readme = process.argv[6] == 0 ? "Success" : "Failure"
var push = process.argv[7] == 0 ? "Success" : "Failure"
var vercel = process.argv[8] == 0 ? "Success" : "Failure"

var text = "- Linter_stage: " + lint + '\n' + "- Test_stage: " + cypress + '\n' + "- Update_readme_stage: " + readme + '\n' + "- Push_stage: " + push + '\n' + "- Deploy_to_Vercel_stage: " + vercel
var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: "santisolerllin@gmail.com",
    pass: pw
  }
});

var mailOptions = {
  from: "santisolerllin@gmail.com",
  to: email,
  subject: "Jenkins results",
  text: text
};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
}); 
