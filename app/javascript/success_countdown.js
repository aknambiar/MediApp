class SuccessCountdown {
    constructor() {
        this.date = document.querySelector('#date').value;
        this.date = this.convertToMMDDYY(this.date);
        this.time = document.querySelector('#time').value;
        this.target = new Date(`${this.date} ${this.time}:00:00`).getTime();


        this.displayCountdown = document.querySelectorAll('.countdown');

        this.countdown;
        setInterval(this.startCountdown.bind(this),1000);
    }

    convertToMMDDYY(ddmmyy) {
        let dates = ddmmyy.split(/\//);
        let mmddyy = `${dates[1]}/${dates[0]}/${dates[2]}`
        return mmddyy
    }

    format_into_two_digits(num) {
        let result = "0" + num;
        return result.slice(-2).split("");
    }

    updateDisplay() {
        this.displayCountdown.forEach((d) => {
            let tag = d.id
            d.firstElementChild.innerText = this.countdown[tag][0]
            d.lastElementChild.innerText = this.countdown[tag][1]
        })
    }

    startCountdown() {
        let now = new Date().getTime();
        let distance = this.target - now;

        let days = Math.floor(distance / (1000 * 60 * 60 * 24));
        let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((distance % (1000 * 60)) / 1000);

        this.countdown = {
            Days: this.format_into_two_digits(days),
            Hours: this.format_into_two_digits(hours),
            Mins: this.format_into_two_digits(minutes),
            Secs: this.format_into_two_digits(seconds),
            }
            
        this.updateDisplay();

    }

    
}

document.addEventListener("turbo:render", (event) => {
    if (document.location.toString().includes("appointments/success")) {
        new SuccessCountdown
    }
  });
  
new SuccessCountdown