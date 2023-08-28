ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              "smtp.gmail.com",
  port:                 587,
  user_name:            "myaccount@gmail.com",
  password:             "abcpassword",
  domain:               "mail.google.com",
  authentication:       :login,
  enable_starttls_auto: true
}