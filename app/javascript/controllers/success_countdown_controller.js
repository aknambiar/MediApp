import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="success-countdown"
export default class extends Controller {
  static targets = [ "date", "time", "clock" ]

  connect() {
    this.date = this.convertToMMDDYY(this.dateTarget.value);
    this.target = new Date(`${this.date} ${this.timeTarget.value}:00:00`).getTime();
    this.millisecondsInMinute = 1000 * 60;
    this.millisecondsInHour = this.millisecondsInMinute * 60;
    this.millisecondsInDay = this.millisecondsInHour * 24;
  
    setInterval(this.startCountdown.bind(this),1000);
  }

  convertToMMDDYY(ddmmyy) {
    let dates = ddmmyy.split(/\//);
    let mmddyy = `${dates[1]}/${dates[0]}/${dates[2]}`;
    return mmddyy;
  }

  formatIntoTwoDigits(num) {
    let result = "0" + num;
    return result.slice(-2).split("");
  }

  updateDisplay() {
    this.clockTargets.forEach((d) => {
      let tag = d.id;
      d.firstElementChild.innerText = this.countdown[tag][0];
      d.lastElementChild.innerText = this.countdown[tag][1];
    })
  }

  startCountdown() {
    let now = new Date().getTime();
    let distance = this.target - now;

    let days = Math.floor(distance / this.millisecondsInDay);
    let hours = Math.floor((distance % this.millisecondsInDay) / this.millisecondsInHour);
    let minutes = Math.floor((distance % this.millisecondsInHour) / this.millisecondsInMinute);
    let seconds = Math.floor((distance % this.millisecondsInMinute) / 1000);

    this.countdown = {
      Days: this.formatIntoTwoDigits(days),
      Hours: this.formatIntoTwoDigits(hours),
      Mins: this.formatIntoTwoDigits(minutes),
      Secs: this.formatIntoTwoDigits(seconds),
    }

    this.updateDisplay();
  }
}
