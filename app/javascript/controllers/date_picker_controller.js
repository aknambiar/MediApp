import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="date-picker"
export default class extends Controller {
  static targets = [ "carouselItem", "slotPicker", "carouselButton" ];

  connect() {
    this.DATES_PER_SLIDE = 3;
    this.carouselItemTargets[0].classList.add('active');
    this.slotPickerTargets[0].classList.remove('d-none');

    this.duplicateCarouselSlides();
    this.setUnderline(this.carouselButtonTargets[0]);
  }

  duplicateCarouselSlides() {
    this.carouselItemTargets.forEach((slide) => {
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

  toggleSlotPicker() {
    this.setUnderline(event.currentTarget);
    let id = event.currentTarget.parentNode.firstElementChild.value;
    this.slotPickerTargets.forEach((element) => element.classList.add('d-none'));
    let selectedDateSlots = document.getElementById(id);
    selectedDateSlots.classList.remove('d-none');
  }

  setUnderline(target) {
    if (window.screen.width > 992 ){
      this.carouselButtonTargets.forEach((button) => button.parentNode.classList.remove ("border", "border-primary", "border-5", "rounded", "fw-bolder", "fs-7", "bg-carousel"));
      this.carouselButtonTargets.forEach((button) => button.parentNode.classList.add ("border-bottom", "border-3", "fs-10"));
      target.parentNode.classList.add ("border-bottom", "border-primary", "border-5", "fw-bolder");
    }
    else {
      this.carouselButtonTargets.forEach((button) => button.parentNode.classList.remove ("border-bottom", "border-3", "border-primary", "border-5", "fw-bolder", "fs-10", "bg-carousel"));
      this.carouselButtonTargets.forEach((button) => button.parentNode.classList.add ("border", "rounded", "fs-7"));
      target.parentNode.classList.add ("border-primary", "bg-carousel");
    }
  }

  enableButton() {
    document.querySelector('[type="submit"]').disabled = false;
  }
}
