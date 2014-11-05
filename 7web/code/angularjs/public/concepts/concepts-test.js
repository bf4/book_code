/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("concepts/concepts-tests.js", function() {
  describe("angular module", function() {
    describe("dependency injection", function() {
      it("works with service and function parameter names", function(done) {
        var app = angular.module("TestApp", []);
        app.service("serviceA", function() {
          this.name = "A";
        });
        app.service("serviceB", function() {
          this.name = "B";
        });
        app.service("serviceC", function(serviceA, serviceB) {
          serviceA.name; // returns "A"
          serviceB.name; // returns "B"
          expect(serviceA.name).toBe("A");
          expect(serviceB.name).toBe("B");
          done();
        });

        app.run(function(serviceC) { });
        angular.bootstrap(document, ["TestApp"]);
      });

      it("works with factory and function parameter names", function(done) {
        var app = angular.module("TestApp", []);
        app.factory("serviceA", function() {
          return {name:"A"};
        });
        app.factory("serviceB", function() {
          return {name:"B"};
        });
        app.factory("serviceC", function(serviceA, serviceB) {
          serviceA.name; // returns "A"
          serviceB.name; // returns "B"
          expect(serviceA.name).toBe("A");
          expect(serviceB.name).toBe("B");
          done();
        });

        app.run(function(serviceC) { });
        angular.bootstrap(document, ["TestApp"]);
      });

      it("works with service and $inject", function(done) {
        var app = angular.module("TestApp", []);

        app.service("serviceA", function() {
          this.name = "A";
        });
        app.service("serviceB", function() {
          this.name = "B";
        });
        var svcC = function(svcA, svcB) {
          svcA.name; // returns "A"
          svcB.name; // returns "B"
          expect(svcA.name).toBe("A");
          expect(svcB.name).toBe("B");
          done();
        };
        svcC.$inject = ["serviceA", "serviceB"];
        app.service("serviceC", svcC);

        var runner = function(svcC) { };
        runner.$inject = ["serviceC"];

        app.run(runner);
        angular.bootstrap(document, ["TestApp"]);
      });

      it("works with factory and $inject", function(done) {
        var app = angular.module("TestApp", []);

        app.factory("serviceA", function() {
          return {name:"A"};
        });
        app.factory("serviceB", function() {
          return {name:"B"};
        });
        var svcC = function(svcA, svcB) {
          svcA.name; // returns "A"
          svcB.name; // returns "B"
          expect(svcA.name).toBe("A");
          expect(svcB.name).toBe("B");
          done();
        };
        svcC.$inject = ["serviceA", "serviceB"];

        app.factory("serviceC", svcC);

        var runner = function(svcC) { };
        runner.$inject = ["serviceC"];

        app.run(runner);
        angular.bootstrap(document, ["TestApp"]);
      });

      it("works with service and inline annotation", function(done) {
        var app = angular.module("TestApp", []);
        app.service("serviceA", function() {
          this.name = "A";
        });
        app.service("serviceB", function() {
          this.name = "B";
        });
        app.service("serviceC", ["serviceA", "serviceB", function(svcA, svcB) {
          svcA.name; // returns "A"
          svcB.name; // returns "B"
          expect(svcA.name).toBe("A");
          expect(svcB.name).toBe("B");
          done();
        }]);

        app.run(["serviceC", function(svcC) { }]);
        angular.bootstrap(document, ["TestApp"]);
      });

      it("works with factory and inline annotation", function(done) {
        var app = angular.module("TestApp", []);
        app.factory("serviceA", function() {
          return {name:"A"};
        });
        app.factory("serviceB", function() {
          return {name:"B"};
        });
        app.factory("serviceC", ["serviceA", "serviceB", function(svcA, svcB) {
          svcA.name; // returns "A"
          svcB.name; // returns "B"
          expect(svcA.name).toBe("A");
          expect(svcB.name).toBe("B");
          done();
        }]);

        app.run(["serviceC", function(svcC) { }]);
        angular.bootstrap(document, ["TestApp"]);
      });
    });
  });

  describe("provider", function() {
    it("can be a value", function(done) {
      var app = angular.module("TestApp", []);
      app.value("ducks", 42);
      app.service("testService", function(ducks) {
        expect(ducks).toBe(42);
        done();
      });

      app.run(function(testService) { });
      angular.bootstrap(document, ["TestApp"]);
    });

    it("can be a factory", function(done) {
      var app = angular.module("TestApp", []);
      app.factory("deleteBookmark", function() {
        return function(bookmark) {
          // delete the bookmark...
        };
      });
      app.service("someService", function(deleteBookmark) {
        var bookmark = null;
        /*
        var bookmark = ...;
        */
        deleteBookmark(bookmark);
      });

      app.factory("quacks", function() {
        return "quack quack";
      });
      app.service("testService", function(quacks) {
        expect(quacks).toBe("quack quack");
        done();
      });

      app.run(function(testService) { });
      angular.bootstrap(document, ["TestApp"]);
    });

    it("can be a service", function(done) {
      var Duck = function() {
        this.quack = function() {
          return "quackity quack";
        };
      };

      var app = angular.module("TestApp", []);
      app.service("DuckService", Duck);
      app.service("testService", function(DuckService) {
        expect(DuckService.quack()).toBe("quackity quack");
        done();
      });

      app.run(function(testService) { });
      angular.bootstrap(document, ["TestApp"]);
    });

    it("can be a service with configuration", function(done) {
      var Duck = function(sound) {
        this.quack = function() {
          return "quack, " + sound;
        };
      };

      var app = angular.module("TestApp", []);
      app.service("DuckService", Duck);
      app.value("sound", "quack!");
      app.service("testService", function(DuckService) {
        expect(DuckService.quack()).toBe("quack, quack!");
        done();
      });

      app.run(function(testService) { });
      angular.bootstrap(document, ["TestApp"]);
    });
  });

  describe("resource", function() {
    it("CRUDs with the server", function(done) {
      var app = angular.module("TestApp", ["ngResource"]);
      app.service("testService", function($resource) {
        expect($resource).toBeDefined();

        var Bookmark = $resource("/bookmarks/:id", {id:"@id"});
        expect(Bookmark).toBeDefined();

        new Bookmark({url:"http://angularjs.org", title:"AngularJS"}).
          $save(function(bookmark) {
            expect(bookmark.id).toBeDefined();
            expect(bookmark.id).toBeGreaterThan(0);

            Bookmark.query(function(bookmarks) {
              expect(bookmarks).toBeDefined();
              expect(bookmarks.length).toBeGreaterThan(0);

              bookmarks[bookmarks.length - 1].$delete(function() {
                done();
              });
            });
          });
      });

      app.run(function(testService) { });
      angular.bootstrap(document, ["TestApp"]);
    });

    it("allows to override default parameter", function(done) {
      var app = angular.module("TestApp", ["ngResource"]);
      app.service("testService", function($resource) {
        var Bookmark = $resource("/bookmarks/:id", {id:"@id"});
        var someId = 11;
        Bookmark.query(function(bookmarks) {
          someId = bookmarks[0].id;

        // This issues a request to /bookmarks/11
        Bookmark.get({id:someId}, function(bookmark) {
          // ...
          expect(bookmark).toBeDefined();
          expect(bookmark.id).toBe(someId);
          done();
        });

        });
      });

      app.run(function(testService) { });
      angular.bootstrap(document, ["TestApp"]);
    });
  });

  describe("testability", function() {
    it("is not easily testable", function() {
      var MyService = function() {
        var myHelper = new MyHelper();
        var result = myHelper.doSomething("test");
        // ...
      };
    });
    it("is easily testable", function() {
      var MyService = function(myHelper) {
        var result = myHelper.doSomething("test");
        // ...
      };
    });
  });
});
