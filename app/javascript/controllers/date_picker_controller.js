import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-picker"
export default class extends Controller {
  static targets = [ "carouselItem", "slotPicker", "slotButton", "carouselButton" ]

  connect() {
    this.DATES_PER_SLIDE = 3;
    this.slides = this.carouselItemTargets
    this.slotButtons = this.slotPickerTargets
    this.individualSlotButtons = this.slotButtonTargets

    this.duplicateCarouselSlides();

    this.carouselButtons = this.carouselButtonTargets
    this.addButtonListeners();

    this.slides[0].classList.add('active');
    this.setUnderline(this.carouselButtons[0]);
    this.slotButtons[0].classList.remove('d-none');
    this.enableButton();
  }

  duplicateCarouselSlides() {
    this.slides.forEach((slide) => {
        let nextSlide = slide.nextElementSibling;
        for (var i = 1 ; i < this.DATES_PER_SLIDE ; i++ ) {
            if (!nextSlide) {
                slide.remove();
                continue;
            }
            let slideContents = nextSlide.cloneNode(true);
            slide.firstElementChild.appendChild(slideContents.children[0].firstElementChild);
            nextSlide = nextSlide.nextElementSibling;
        }
    })
}

addButtonListeners() {
    this.carouselButtons.forEach((button) => {
        button.addEventListener('click', (event) => {
            this.setUnderline(button);
            let id = button.parentNode.firstElementChild.value;
            this.slotButtons.forEach((element) => element.classList.add('d-none'));
            let selectedDateSlots = document.getElementById(id);
            selectedDateSlots.classList.remove('d-none');
        })
    })
}

setUnderline(target) {
    if (window.screen.width > 992 ){
        this.carouselButtons.forEach((button) => button.parentNode.classList.remove ("border", "border-primary", "border-5", "rounded", "fw-bolder", "fs-7", "bg-carousel"));
        this.carouselButtons.forEach((button) => button.parentNode.classList.add ("border-bottom", "border-3", "fs-10"));
        target.parentNode.classList.add ("border-bottom", "border-primary", "border-5", "fw-bolder");
    }
    else {
        this.carouselButtons.forEach((button) => button.parentNode.classList.remove ("border-bottom", "border-3", "border-primary", "border-5", "fw-bolder", "fs-10", "bg-carousel"));
        this.carouselButtons.forEach((button) => button.parentNode.classList.add ("border", "rounded", "fs-7"));
        target.parentNode.classList.add ("border-primary", "bg-carousel");
    }
}

enableButton() {
    document.body.addEventListener("click", function(event){
        if(event.target.classList.contains("slot-radio-button")){
            document.querySelector('[type="submit"]').disabled = false
        }
    });
}
}
