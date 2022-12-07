"use strict";
window.addEventListener('DOMContentLoaded', init);
function init(){
    const dropdowns = document.getElementsByClassName('dd');
    for (var i = 0, len = dd.length ; i < len; i++){
        dd[i].addEventListener('click', changeContent, false)
    }
}
function changeContent(id){
   let show_hide = document.getElementsByClassName('special_container')
    for (i = 0; i < show_hide.length; i++) {
        show_hide[i].style.display = "none";
        console.log("second");
    }
    [document.getElementsById(id)].style.display = "block";
}

