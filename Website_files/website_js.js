

function init() {
    console.log("init");
    let dropdowns = document.getElementsByClassName('dropdown-content');
    let childrenOfDropdown;
    for (let i = 0; i < dropdowns.length; i++) {
        childrenOfDropdown = dropdowns[i].children;
        for (let j = 0; j < childrenOfDropdown.length; j++) {
            childrenOfDropdown[j].addEventListener('click', function () {
                changeContent(
                "letter" + ((i+1)*(j+1)))
                console.log(i);
                console.log(j);
            });
        }
    }
}

function changeContent(id) {
    let show_hide = document.getElementsByClassName('special_container')
    for (i = 0; i < show_hide.length; i++) {
        show_hide[i].style.display = "none";
    }
    console.log(id);
    document.getElementById(id).style.display = "block";
}

window.addEventListener('DOMContentLoaded', init, false);
console.log("bootstrapping event");