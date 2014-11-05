/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/

modit('app.user', function() {
  function named(user) {
    user.fullName = function() {
      return user.first_name + ' ' + user.last_name;
    };
    return user;
  }

  function mailable(user) {
    user.mailingAddress = function() {
      return user.address.street + "\n" +
        user.address.city + ", " + 
          user.address.state + ' ' +
          user.address.zip;
    };
    return user;
  }
  this.exports(named, mailable);
});

modit('app.user', function() {
  function fullName(user) {
    return user.first_name + ' ' + user.last_name;
  }

  function phoneBook(user) {
    return user.phone_numbers;
  }

  function phoneNumbers(phoneBook) {
    return _.flatten(_.map(phoneBook, _.values));
  }

  this.exports(fullName, phoneNumbers, phoneBook);
});
