class DatePicker {
    static DATES_PER_SLIDE = 3;
    constructor() {
        this.slides = document.querySelectorAll('#date-picker .carousel-item');
        this.slotButtons = document.querySelectorAll('.slot-picker');
        this.individualSlotButtons = document.querySelectorAll('.slot-picker label div');

        this.duplicateCarouselSlides();

        this.carouselButtons = document.querySelectorAll('#date-picker .carousel-inner label');
        this.addButtonListeners();

        this.slides[0].classList.add('active');
        this.setUnderline(this.carouselButtons[0]);
        this.slotButtons[0].classList.remove('d-none');
    }

    duplicateCarouselSlides() {
        this.slides.forEach((slide) => {
            let nextSlide = slide.nextElementSibling;
            for (var i = 1 ; i < DatePicker.DATES_PER_SLIDE ; i++ ) {
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
            this.carouselButtons.forEach((button) => button.parentNode.classList.remove ("border", "border-primary", "border-5", "rounded"));
            this.carouselButtons.forEach((button) => button.parentNode.classList.add ("border-bottom","border-3"));
            target.parentNode.classList.add ("border-bottom","border-primary","border-5");
        }
        else {
            this.carouselButtons.forEach((button) => button.parentNode.classList.remove ("border-bottom", "border-3", "border-primary", "border-5"));
            this.carouselButtons.forEach((button) => button.parentNode.classList.add ("border", "rounded"));
            target.parentNode.classList.add ("border-primary");
        }
    }
}

document.addEventListener("turbo:render", (event) => {
    if (document.location.toString().includes("appointments/new")) {
        new DatePicker;
    }
  });
  
new DatePicker;