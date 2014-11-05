/***
 * Excerpted from "The Cucumber Book",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
***/
function Search(form) {
  this.form = form;
}
Search.prototype.queue = function (query) {
  if (this.timer) {
    clearTimeout(this.timer);
  }
  var self = this;
  this.timer = setTimeout(function () {
    self.search(query);
  }, 150);
};

Search.prototype.search = function (query) {
  var self = this;
  jQuery.ajax({
    url: this.form.action,
    type: this.form.method,
    data: {'query': query},
    success: function(results) {self.render(results)},
    contentType: 'application/json',
    dataType: 'json'
  });
}

Search.prototype.render = function (results) {
  var html = "";
  for (var i = 0, l = results.length; i < l; ++i) {
    var url = '/users/' + results[i].user_id + '/messages/' + results[i].id;
    html += '<li><a href="' + url + '">' + results[i].content + '</a></li>';
  }
  jQuery(this.form).find('ol.results').html(html);
}

jQuery.fn.search = function () {
  this.each(function () {
    var search = new Search(this);
    var input = jQuery(this).find("input[type=text]");

    input.bind('keyup', function () {
      search.queue(this.value);
    });
  });
};

jQuery(function() {
  jQuery('#search').search();
});
