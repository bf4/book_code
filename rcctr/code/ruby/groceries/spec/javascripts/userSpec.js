/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/

describe('User', function() {
  var response;

  beforeEach(function() {
    response = {
      first_name: 'Bob',
      last_name: 'Dobilina',
      user_name: 'bdob',
      address: {
        street: '123 Fake St.',
        street2: '',
        city: 'Chicago',
        state: 'IL',
        zip: '60613'
      },
      phone_numbers: [
        { home: '773-555-2827' },
        { work: '773-555-2827' },
        { mobile1: '312-555-1212'},
        { mobile2: '773-555-1234'}
      ]
    };
  });

  it('has a first and last name', function() {
    expect(response.first_name + ' ' + response.last_name).toEqual('Bob Dobilina');
  });

  function User(response) {
    this.fullName = function() {
      return response.first_name + ' ' + response.last_name;
    };
  }

  // And in the test...
  it('has a full name', function() {
    var user = new User(response);
    expect(user.fullName()).toEqual('Bob Dobilina');
  });
  
  describe('a functional user', function() {
    var user;

    beforeEach(function() {
      var mod = require('specHelper').user;
      user = mod.named(mod.mailable(response));
    });

    it('has a full name', function() {
      expect(user.fullName()).toEqual('Bob Dobilina');
    });

    it('has a mailing address', function() {
      expect(user.mailingAddress()).toEqual('1060 W. Addison\nChicago, IL 60613');
    });
  });
  
  describe('a composed user', function() {
    var user;

    beforeEach(function() {
      user = require('specHelper').user;
    });
    
    it('has a name', function() {
      expect(user.fullName(response)).toEqual('Bob Dobilina');
    });

    it('has a phone book', function() {
      expect(user.phoneBook(response)).toContain(
        {home: '773-555-2827'}, 
        {mobile1: '312-555-1212'}
      );
    });

    it('makes extracting mobile phone numbers easy', function() {
      function mobile(phoneBook) {
        return _.select(phoneBook, function(entry) {
          return _.first(_.keys(entry)).indexOf('mobile') === 0;
        });
      }

      numbers = _.compose(user.phoneNumbers, mobile, user.phoneBook);

      expect(numbers(response)).toEqual(['312-555-1212', '773-555-1234']);
    });
  });
});
