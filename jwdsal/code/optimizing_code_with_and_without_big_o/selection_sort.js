/***
 * Excerpted from "A Common-Sense Guide to Data Structures and Algorithms",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/jwdsal for more book information.
***/
function selectionSort(array) {
  for(var i = 0; i < array.length; i++) {
    var smallestNumberIndex = i;
    for(var j = i + 1; j < array.length; j++) {
      if(array[j] < array[smallestNumberIndex]) {
        smallestNumberIndex = j;
      }
    }
 
    if(smallestNumberIndex != i) {
      var temp = array[i];
      array[i] = array[smallestNumberIndex];
      array[smallestNumberIndex] = temp;
    }
  }
  return array;
}