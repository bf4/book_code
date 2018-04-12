import React           from 'react'              // (1)
import ReactDOM        from 'react-dom'           // (2)
import PayTypeSelector from 'PayTypeSelector'     // (3)

document.addEventListener('turbolinks:load', function() {       // (4)
  var element = document.getElementById("pay-type-component"); // (5)
  ReactDOM.render(<PayTypeSelector />, element);                 // (6)
});
