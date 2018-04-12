/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
document.addEventListener('DOMContentLoaded', function() {
  // Stuff to do once the page is loaded
  fetchMenuItems()
    .then(displayMenuItems)
    .catch(displayFetchError);
});

function displayFetchError(response) {
  var element = document.createElement('p');
  element.innerHTML = 'Could not contact API.';
  console.error("Fetch Error", response);
  document.body.appendChild(element);
}

function fetchMenuItems() {
  return window.fetch('http://localhost:4000/api', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      query: '{ menuItems { name } }'
    })
  }).then(function(response) {
    return response.json();
  });
}

function displayMenuItems(result) {
  var element;
  if (result.errors) {
    var element = document.createElement('p');
    element.innerHTML = 'Could not retrieve menu items.';
    console.error("GraphQL Errors", result.errors);
  } else if (result.data.menuItems) {
    var element = document.createElement('ul');
    result.data.menuItems.forEach(function(item) {
      var itemElement = document.createElement('li');
      itemElement.innerHTML = item.name;
      element.appendChild(itemElement);
    });
  }
  document.body.appendChild(element);
}
