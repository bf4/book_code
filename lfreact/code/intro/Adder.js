/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
function Adder({ n1, n2 }) {
  const sum = n1 + n2;
  return React.createElement('h1', {}, sum);
}

ReactDOM.render(
  React.createElement(Adder, { n1: 2, n2: 4 }),
  document.getElementById('app')
);

function Adder({ n1, n2 }) {
  const sum = n1 + n2;
  return <h1>{sum}</h1>;
}

ReactDOM.render(<Adder n1={2} n2={4} />, document.getElementById('app'));
