/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
accessLevel = 1;

function canAccess(lvl) {
    // Lets do some arbitrary calculation to determine the applicable value
    accessLevel = accessLevel + 5;

    return accessLevel < lvl; // are we authorized
}

if(canAccess(10)) { // Won't run since we don't have access
    console.log('We have access');
}

if(canAccess(10)) { // This will succeed, because we are accumulating results
    console.log('Try again, because we are daft');
}