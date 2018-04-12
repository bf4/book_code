/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import { connect } from 'react-redux';
import { FILTER_CHANGED } from './actions';
import Checkbox from './Checkbox';

function mapDispatchToProps(dispatch) {
  return {
    onChange: filter => {
      dispatch({ type: FILTER_CHANGED, filter });
    }
  };
}

function mapStateToProps(state) {
  return {
    checked: state.filter
  };
}
export default connect(mapStateToProps, mapDispatchToProps)(Checkbox);
