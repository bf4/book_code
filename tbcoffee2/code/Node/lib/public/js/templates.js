/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
if (!window.JST) {
  window.JST = {};
}
window.JST["templates/board"] = function(__obj) {
  var _safe = function(value) {
    if (typeof value === 'undefined' && value == null)
      value = '';
    var result = new String(value);
    result.ecoSafe = true;
    return result;
  };
  return (function() {
    var __out = [], __self = this, _print = function(value) {
      if (typeof value !== 'undefined' && value != null)
        __out.push(value.ecoSafe ? value : __self.escape(value));
    }, _capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return _safe(result);
    };
    (function() {
      var column, _i, _len, _ref;
    
      _print(_safe('<input name=\'board-name\' value=\''));
    
      _print(this.name);
    
      _print(_safe('\'>\n<div class=\'column-container\'>\n  '));
    
      _ref = this.columns;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        column = _ref[_i];
        _print(_safe('\n    <div class=\'column\' data-column-id=\''));
        _print(column.id);
        _print(_safe('\'></div>\n  '));
      }
    
      _print(_safe('\n  <button name=\'add-column\'>Add Column</button>\n</div>\n'));
    
    }).call(this);
    
    return __out.join('');
  }).call((function() {
    var obj = {
      escape: function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      },
      safe: _safe
    }, key;
    for (key in __obj) obj[key] = __obj[key];
    return obj;
  })());
};

if (!window.JST) {
  window.JST = {};
}
window.JST["templates/card"] = function(__obj) {
  var _safe = function(value) {
    if (typeof value === 'undefined' && value == null)
      value = '';
    var result = new String(value);
    result.ecoSafe = true;
    return result;
  };
  return (function() {
    var __out = [], __self = this, _print = function(value) {
      if (typeof value !== 'undefined' && value != null)
        __out.push(value.ecoSafe ? value : __self.escape(value));
    }, _capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return _safe(result);
    };
    (function() {
      _print(_safe('<textarea name=\'card-description\' placeholder=\'Description\'\n  rows=\'3\'>'));
    
      _print(this.description);
    
      _print(_safe('</textarea>\n<label class=\'due-date-label\'><span>Due by:</span><input type=\'date\'\n  name=\'due-date\' value=\''));
    
      _print(this.dueDate);
    
      _print(_safe('\'></label>\n'));
    
    }).call(this);
    
    return __out.join('');
  }).call((function() {
    var obj = {
      escape: function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      },
      safe: _safe
    }, key;
    for (key in __obj) obj[key] = __obj[key];
    return obj;
  })());
};

if (!window.JST) {
  window.JST = {};
}
window.JST["templates/column"] = function(__obj) {
  var _safe = function(value) {
    if (typeof value === 'undefined' && value == null)
      value = '';
    var result = new String(value);
    result.ecoSafe = true;
    return result;
  };
  return (function() {
    var __out = [], __self = this, _print = function(value) {
      if (typeof value !== 'undefined' && value != null)
        __out.push(value.ecoSafe ? value : __self.escape(value));
    }, _capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return _safe(result);
    };
    (function() {
      var card, _i, _len, _ref;
    
      _print(_safe('<input name=\'column-name\' value=\''));
    
      _print(this.name);
    
      _print(_safe('\'>\n<div class=\'card-container\'>\n  '));
    
      _ref = this.cards;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        card = _ref[_i];
        _print(_safe('\n    <div class=\'card\' data-card-id=\''));
        _print(card.id);
        _print(_safe('\'></div>\n  '));
      }
    
      _print(_safe('\n  <button name=\'add-card\'>Add Card</button>\n</div>\n'));
    
    }).call(this);
    
    return __out.join('');
  }).call((function() {
    var obj = {
      escape: function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      },
      safe: _safe
    }, key;
    for (key in __obj) obj[key] = __obj[key];
    return obj;
  })());
};
