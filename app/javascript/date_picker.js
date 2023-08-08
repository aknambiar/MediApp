let dateList = document.querySelectorAll('.carousel .carousel-item')

dateList.forEach((date) => {
    const noOfDatesToShow = 3 
    let next = date.nextElementSibling
    for (var i = 1 ; i < noOfDatesToShow ; i++ ) {
        if (next) {
            let nextDate = next.cloneNode(true)
            date.firstElementChild.appendChild(nextDate.children[0].firstElementChild)
            next = next.nextElementSibling
        }
    }
})