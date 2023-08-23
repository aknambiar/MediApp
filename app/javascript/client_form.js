class ClientForm {
    constructor() {
        this.currencyButtons = document.querySelectorAll('.currency-buttons');
        this.paymentButton = document.querySelector('.payment');

        this.addButtonListeners();

        this.addSubmitButtonSpinner();
    }

    addButtonListeners() {
        this.currencyButtons.forEach((button) => {
            button.addEventListener('click', (event) => {
                let rate = button.firstElementChild.getAttribute('rate')
                rate = (Math.round(rate * 100) / 100).toFixed(2);

                let currency = button.firstElementChild.getAttribute('value')
                
                this.paymentButton.value = `Pay ${rate} ${currency}`
          })
        })
    }

    addSubmitButtonSpinner() {
        let spinner = this.paymentButton.nextElementSibling
        this.paymentButton.addEventListener('click', (event) => {
            this.paymentButton.classList.add("d-none")
            spinner.classList.remove("d-none")
      })
    }

}

document.addEventListener("turbo:render", (event) => {
    if (document.location.toString().includes("clients/form")) {
        new ClientForm
    }
  });
  
new ClientForm