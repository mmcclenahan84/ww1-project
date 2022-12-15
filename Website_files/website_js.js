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



//Emote
function positiveFunction() {
  var checkBox = document.getElementById("positive");
  var topics = document.getElementsByClassName("positive");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.textDecoration('underline');
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('textDecoration');
        
     }
  }
}function negativeFunction() {
  var checkBox = document.getElementById("negative");
  var topics = document.getElementsByClassName("negative");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.fontWeight('bold');
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('fontWeight');
        
     }
  }
}function neutralFunction() {
  var checkBox = document.getElementById("neutral");
  var topics = document.getElementsByClassName("neutral");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.fontStyle('italic');
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('fontStyle');
        
     }
  }
}
//Factor
function traumaFunction() {
  var checkBox = document.getElementById("trauma");
  var topics = document.getElementsByClassName("trauma");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.color = 'red';
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('color');
        
     }
  }
}
function battleFunction() {
  var checkBox = document.getElementById("battle");
  var topics = document.getElementsByClassName("battle");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.color = 'SaddleBrown';
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('color');
        
     }
  }
}function prepFunction() {
  var checkBox = document.getElementById("prep");
  var topics = document.getElementsByClassName("prep");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.color = 'DarkBlue';
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('color');
        
     }
  }
}function conditionsFunction() {
  var checkBox = document.getElementById("conditions");
  var topics = document.getElementsByClassName("conditions");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.color = 'DarkOliveGreen';
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('color');
        
     }
  }
}function senseFunction() {
  var checkBox = document.getElementById("sense");
  var topics = document.getElementsByClassName("trauma");

  if (checkBox.checked == true){
    for (var i = 0; i < topics.length; i++) {
        topics[i].style.color = 'DarkGoldenrod';
     }
  } else {
        for (var i = 0; i < topics.length; i++) {
        topics[i].style.removeProperty('color');
        
     }
  }
}