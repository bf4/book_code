/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var map = {};

function time(str) {
    map[str] = process.hrtime();
}

function timeEnd(str) {
    var hrTime = process.hrtime(map[str]);
    return Math.round((hrTime[0] * 1000000 + hrTime[1]) / 1000);
}

function formatPrint(micro, str) {
    if(micro > 10000) {
        console.log(str + ': ' + Math.round(micro / 1000) + 'ms');
        return;
    }
    console.log(str + ': ' + micro + 'μs');
}


module.exports  = {
    time: time,
    timeEnd: timeEnd,
    formatPrint: formatPrint
};