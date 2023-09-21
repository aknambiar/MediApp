module Constants
  ACCEPTED_CURRENCIES = ["INR", "USD", "EUR"]
  PRICE = 500.0
  SCHEDULING_RANGE = 9
  COUNTDOWN_FIELDS = ["Days", "Hours", "Mins", "Secs"]
  DOWNLOAD_FORMATS = ["csv", "txt", "pdf"]
  CANCEL_TIME_LIMIT = 30
  INVOICE_SAVE_PATH = "storage/invoices"
  EMAIL_REGEXP = Regexp.new(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  WORKING_HOURS_REGEXP = Regexp.new(/^(0[1-9]|1[0-9]|2[0-4])(,(0[1-9]|1[0-9]|2[0-4]))*$/)
end
