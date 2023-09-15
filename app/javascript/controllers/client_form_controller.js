import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="client-form"
export default class extends Controller {
  static targets = [ "currencyButton", "paymentButton"]

  connect() {
    this.addSubmitButtonSpinner();
    this.addButtonListeners();
  }

  addButtonListeners() {
    this.currencyButtonTargets.forEach((button) => {
        button.addEventListener('click', (event) => {
            let rate = button.firstElementChild.getAttribute('rate');
            rate = (Math.round(rate * 100) / 100).toFixed(2);

            let currency = button.firstElementChild.getAttribute('value');
            
            this.paymentButtonTarget.value = `Pay ${rate} ${currency}`;
        })
    })
  }

  addSubmitButtonSpinner() {
    let spinner = this.paymentButtonTarget.nextElementSibling;
    let form = document.querySelector('form');
    form.addEventListener('submit', (event) => {
      this.paymentButtonTarget.classList.add("d-none");
        spinner.classList.remove("d-none");
    })
  }
}
