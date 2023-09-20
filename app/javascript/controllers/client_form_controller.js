import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="client-form"
export default class extends Controller {
  static targets = [ "currencyButton", "emailField", "emailError", "form", "paymentButton"];

  updatePaymentButton() {
    let rate = event.currentTarget.nextElementSibling.getAttribute('rate');
    rate = (Math.round(rate * 100) / 100).toFixed(2);
    let currency = event.currentTarget.nextElementSibling.getAttribute('value');
    this.paymentButtonTarget.value = `Pay ${rate} ${currency}`;
  }

  validateEmailWhileTyping() {
    if (this.validateEmail(this.emailFieldTarget.value)) {
      this.emailFieldTarget.classList.remove("is-invalid")
    }
    else {
      this.emailFieldTarget.classList.add("is-invalid")
    }
  }

  validateForm() {
    if (this.validateEmail(this.emailFieldTarget.value)) {
      let spinner = this.paymentButtonTarget.nextElementSibling;
      this.paymentButtonTarget.classList.add("d-none");
      spinner.classList.remove("d-none");
      this.formTarget.submit();
    }
    else {
      this.emailErrorTarget.classList.remove("d-none");
    }
  }

  validateEmail(email) {
    return email.toLowerCase().match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
  }
}
