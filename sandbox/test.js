"use strict";
window.addEventListener("DOMContentLoaded", init);
function init() {
  const buttons = document.getElementsByTagName('button')
  for (var i = 0, len = buttons.length; i < len; i++) {
    buttons[i].addEventListener('click', stuff, false);
  }
}
function stuff(e) {
  console.log(e.target.id);
}