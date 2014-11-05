/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("concepts/concepts-tests.js", function() {
  describe("can.Construct", function() {
    it("defines prototype properties for one parameter", function() {
      var Example = can.Construct.extend({
        count: 1,
        increment: function() {
          this.count++;
        }
      });

      var example = new Example();
      expect(example.count).toBe(1);

      example.increment(); // example.count is now 2
      expect(example.count).toBe(2);

      var ExampleStatic = can.Construct.extend({
        staticCount: 4
      }, {
      });

      var exampleS = new ExampleStatic();
      expect(exampleS.constructor.staticCount).toBe(4);
    });

    it("calls init function when creating new object", function() {
      var Example = can.Construct.extend({
        init: function(count) {
          this.count = count;
        }
      });
      var example = new Example(42); // example.count is 42
      expect(example.count).toBe(42);
    });

    it("defines static and prototype properties", function() {
      var Example = can.Construct.extend({
        staticCount: 0,
      }, {
        protoCount: 0
      });

      var example1 = new Example();
      var example2 = new Example();

      example1.constructor.staticCount = 2;
      example1.protoCount = 2;

      Example.staticCount; // returns 2
      example2.constructor.staticCount; // returns 2
      example2.protoCount; // returns 0

      expect(Example.staticCount).toBe(2);
      expect(example2.constructor.staticCount).toBe(2);
      expect(example2.protoCount).toBe(0);
    });

    it("calls init on both static and proto", function() {
      var Example = can.Construct.extend({
        init: function() {
          this.initFromStatic = true;
        }
      }, {
        init: function(obj) {
          obj.initFromProto = true;
        }
      });

      expect(Example.initFromStatic).toBe(true);

      var spy = {};
      new Example(spy);
      expect(spy.initFromProto).toBe(true);
    });

    it("inherits and overrides properties, calls super", function() {
      var Parent = can.Construct.extend({
        init: function(count) {
          this.count = count;
        },
        increase: function() {
          this.count++;
        },
        read: function(prefix) {
          return prefix + " " + String(this.count);
        }
      });

      var Child = Parent({
        // Child inherits the init function

        // Override increase
        increase: function() {
          this.count += 10;
        },
        // Add new function: decrease
        decrease: function() {
          this.count--;
        },
        // Override read, but call parent's version
        read: function() {
          return this._super("Count is") + "!";
        }
      });

      var child = new Child(2); // calls Parent's init
      child.increase(); // calls Child's increase
      child.decrease(); // calls Child's decrease
      child.count; // returns 11
      child.read(); // returns "Count is 11!"

      expect(child.count).toBe(11);
      expect(child.read()).toBe("Count is 11!");
    });

    it("can call super", function() {
      var Parent = can.Construct.extend({
        init: function(firstName) {
          this.firstName = firstName;
        },
        greet: function() {
          return "Hello, " + this.firstName;
        }
      });

      var Child = Parent({
        init: function(firstName, lastName) {
          this._super(firstName);
          this.lastName = lastName;
        },
        greet: function() {
          return this._super() + " " + this.lastName;
        }
      });

      var child = new Child("Nadia", "Di Lena");
      expect(child.greet()).toBe("Hello, Nadia Di Lena");
    });
  });
  describe("can.Control", function() {
    it("receives an element and an options object", function() {
      var MyControl = can.Control.extend({
        init: function(element, options) {
          var view = "/concepts/bookmarks";
		  
          element.html(view, {bookmarks:options.bookmarks});
        }
      });

      var bookmarks = []; // this would normally be the real list of bookmarks
      var options = {bookmarks:bookmarks};
      new MyControl("#bookmark_container", options);
    });

    it("listens to UI events", function() {
      var MyControl = can.Control.extend({
        // Listen for click events on buttons
        "button click": function(el, evt) {
          // ...
        },
        // Listen for change events on checkboxes under elements with class="item"
        ".item :checkbox change": function(el, evt) {
          // ...
        }
      });
    });
  });
  describe("basic fixture", function() {
    it("mocks out Ajax request", function() {
        /* START:Fixture
can.fixture("GET /bookmarks", function() {
  return [
    {id: 1, url:"http://one.com", title:"One"},
    {id: 2, url:"http://two.com", title:"Two"}
  ];
});

can.fixture("GET /bookmarks/{id}", function(req) {
  return
    {id: req.data.id, url:"http://one.com", title:"One"}
})
    });
  });
  describe("list filter", function() {
    var original = null;
    var filtered = null;

    beforeEach(function() {
      original = new can.Observe.List([1, 2, 3, 4, 5]);
      filtered = original.filter(function(item) {
        return item % 2 == 0;
      });
    });

    describe("filtered list", function() {
      it("filters the original list", function() {
        expect(filtered.length).toBe(2);
      });

      it("updates on original list change", function() {
        original.push(6);
        expect(filtered.length).toBe(3);
      });

      it("can use a filter object", function() {
        var filterObject = {
          max: 4,
          filterFunction: function(item) {
            return item <= this.max;
          }
        };
        var filteredList = original.filter(filterObject.filterFunction.bind(filterObject));

        expect(filteredList.length).toBe(4);
      });

      it("updates on filter change", function() {
        var filterObject = new can.Observe({
          max: 4,
          filterFunction: function(item) {
            return item <= this.attr("max");
          }
        });
        var filteredList = original.filter(filterObject.attr("filterFunction").bind(filterObject));

        filterObject.attr("max", 2);

        expect(filteredList.length).toBe(2);
      });
    });
  });
  describe("can.Observe", function() {
    it("notifies of attribute changes", function() {
      // Create an observe
      var observe = new can.Observe({});

      // Listen for changes on the "title" attribute
      observe.bind("title", function(evt, newTitle, oldTitle) {
        console.log("title: newTitle=", newTitle, "oldTitle=", oldTitle);
      });

      // Set a value for the "title" attribute
      observe.attr("title", "First");
      // the console logs:
      // title: newTitle= First oldTitle= undefined

      // Set another value for the "title" attribute
      observe.attr("title", "Second");
      // the console logs:
      // title: newTitle= Second oldTitle= First

      observe.bind("change", function(evt, attr, how, newValue, oldValue) {
        console.log("change: attr=", attr, "how=", how,
          "newValue=", newValue, "oldValue=", oldValue);
      });
      observe.attr("title", "Third");
      // change: attr= title how= set newValue= Third oldValue= Second
      observe.removeAttr("title");
      // change: attr= title how= remove newValue= undefined oldValue= Third
    });

    it("notifies of list changes", function() {
      var observe = new can.Observe.List([42, 44, 46]);
      observe.bind("add", function(evt, newValues, index) {
        console.log("add: newValues=", newValues, "index=", index);
      });
      observe.bind("remove", function(evt, oldValues, index) {
        console.log("remove: oldValues=", oldValues, "index=", index);
      });

      observe.push(48);
      // add: newValues= [48] index= 3
      observe.splice(1, 2);
      // remove: oldValues= [44, 46] index= 1
    });
  });
  describe("basic route", function() {
    it("updates on location hash change", function() {
        /* START:Route
location.hash = "#!action=filter"
can.route.attr("action"); // returns "filter"
           END:Route */
    });

    it("updates the location hash", function() {
        /* START:Route
can.route.attr("tag", "Frameworks");
location.hash; // returns "#!&action=filter&tag=Frameworks"
           END:Route */
    });
  });
});
