class DatePicker {
    static DATES_PER_SLIDE = 3;
    constructor() {
        this.slides = document.querySelectorAll('#date-picker .carousel-item');
        this.slotButtons = document.querySelectorAll('.slot-picker');
        this.individualSlotButtons = document.querySelectorAll('.slot-picker label div')

        this.duplicateCarouselSlides();

        this.carouselButtons = document.querySelectorAll('#date-picker .carousel-inner label');
        this.addButtonListeners();

        this.slides[0].classList.add('active');
        this.setUnderline(this.carouselButtons[0])
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

    // addButtonListeners() {
    //     this.carouselButtons.addEventListener('click', (event) => {
    //         if (event.target.nodeName === 'BUTTON') {
    //             this.slotButtons.forEach((element) => element.classList.add('d-none'));
    //             let selectedDateSlots = document.querySelector("#slot-"+event.target.id.slice(-2));
    //             selectedDateSlots.classList.remove('d-none');
    //         }
    //       })
    // }

    addButtonListeners() {
        this.carouselButtons.forEach((button) => {
            button.addEventListener('click', (event) => {
                this.setUnderline(button)
                let id = button.firstElementChild.value.slice(0,2)
                this.slotButtons.forEach((element) => element.classList.add('d-none'));
                let selectedDateSlots = document.querySelector("#slot-"+id);
                selectedDateSlots.classList.remove('d-none');
          })
        })
    }

    setUnderline(target) {
        this.carouselButtons.forEach((button) => button.classList = "col-4 pb-3 border-bottom border-3")
        target.classList = "col-4 pb-3 border-bottom border-primary border-5"
    }
}
document.addEventListener("turbo:render", (event) => {
    if (document.location.toString().includes("appointments/new")) {
        new DatePicker
    }
  });
  
new DatePicker