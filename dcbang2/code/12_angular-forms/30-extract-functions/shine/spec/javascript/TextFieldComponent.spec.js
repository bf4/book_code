/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
***/
import "./SpecHelper";
import { TextFieldComponent } from "TextFieldComponent";

var component = null;

describe("TextFieldComponent", function() {
  beforeEach(function() {
    component = new TextFieldComponent();
  });

  describe("modelValid", function() {
    it("returns false if the model is dirty and invalid", function() {
      var model = {
        dirty: true,
        invalid: true
      }
      expect(component.modelValid(model)).toBe(false);
    });
    it("returns true if the model is dirty but valid", function() {
      var model = {
        dirty: true,
        invalid: false
      }
      expect(component.modelValid(model)).toBe(true);
    });
    it("returns true if the model is invalid but not dirty", function() {
      var model = {
        dirty: false,
        invalid: true
      }
      expect(component.modelValid(model)).toBe(true);
    });
  });
  describe("validationPattern", function() {
    it("returns a catch-all if pattern is null",function() {
      component.pattern = null;
      expect(component.validationPattern()).toBe("^.*$")
    });
    it("returns the pattern if it's set",function() {
      var pattern = "abcde";
      component.pattern = pattern;
      expect(component.validationPattern()).toBe(pattern);
    });
  });
});
