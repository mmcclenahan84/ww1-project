"use strict";
window.addEventListener('DOMContentLoaded', init);
function init() {
    const dropdowns = document.getElementsByClassName('dd');
    for (let i = 0, len = dropdowns.length; i < len; i++) {
        dropdowns[i].addEventListener('click', changeContent, false)
    }
}
function changeContent(e) {
    let letters = document.getElementsByClassName('special_container');
    for (let i = 0; i < letters.length; i++) {
        letters[i].style.display = "none";
        console.log("second");
    }
    let calc_id = "letter" + this.id.substring(2);
    console.log(calc_id);
    document.getElementById(calc_id).style.display = "block";
}
