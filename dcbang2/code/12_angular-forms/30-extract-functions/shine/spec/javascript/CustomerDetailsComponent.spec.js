/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
***/
import "./SpecHelper";
import { CustomerDetailsComponent } from "CustomerDetailsComponent";
import td from "testdouble/dist/testdouble";

var component = null;

describe("CustomerDetailsComponentComponent", function() {
  describe("initial state", function() {
    beforeEach(function() {
      component = new CustomerDetailsComponent();
    });
    it("sets customer to null", function() {
      expect(component.customer).toBe(null);
    });
  });

  describe("ngOnInit", function() {

    // ...
    
    var customer = {
      id: 1,
      created_at: (new Date()).toString(),
      first_name: "Pat",
      last_name: "Jones",
      username: "pj",
      email: "pjones@somewhere.net"
    }

    // more setup to come...
    
    var createMockHttp = function(customer) {
      var response = td.object(["json"]);
      td.when(response.json()).thenReturn({ customer: customer });

      var observable = td.object(["subscribe", "map"]);

      td.when(observable.map(
        td.callback(response)
      )).thenReturn(observable);

      td.when(observable.subscribe(
        td.callback(customer),
        td.matchers.isA(Function))).thenReturn();

      var mockHttp = td.object(["get"]);

      td.when(
        mockHttp.get("/customers/" + customer.id + ".json")
      ).thenReturn(observable);

      return mockHttp;
    }

    var createMockRoute = function(id) {
      var observable  = td.object(["subscribe"]);
      var routeParams = { "id" : id };
      var mockActivatedRoute = { "params": observable };

      td.when(observable.subscribe(
        td.callback(routeParams),
        td.matchers.isA(Function)
      )).thenReturn();

      return mockActivatedRoute;
    }

    beforeEach(function() {
      var route = createMockRoute(customer.id);
      var http  = createMockHttp(customer);

      component = new CustomerDetailsComponent(route,http);
    });

    it("fetches the customer from the back-end", function() {
      component.ngOnInit();
      expect(component.customer).toBe(customer);
    });
  });
});
