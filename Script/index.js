'use strict'           
let timeId= null; 

function printTime(){
    const date= new Date();
    const hh= date.getHours();
    const mm= date.getMinutes();
    const ss= date.getSeconds();

    document.getElementById("result").innerHTML = hh + " : " + mm + " : " + ss
}

const timeP = setInterval(printTime, 1000);

function startClock(){
    clearInterval(timeP);
    timeId=setInterval(printTime,1000)
}


function stopClock(){
    clearInterval(timeP);
    clearInterval(timeId)
}

// 'use strict';

// let timeId = null;

// function printTime() {
//     const date = new Date();
//     const hh = date.getHours();
//     const mm = date.getMinutes();
//     const ss = date.getSeconds();
    
//     document.getElementById("result").innerHTML = hh + " : " + mm + " : " + ss;
// }

// timeId = setInterval(printTime, 1000);

// function startClock() {
//     timeId = setInterval(printTime, 1000);
// }

// function stopClock() {
//     clearInterval(timeId);
// }
