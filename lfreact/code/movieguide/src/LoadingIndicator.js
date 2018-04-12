/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import { connect } from 'react-redux';

function LoadingIndicator({ loading, children }) {
  if (loading) {
    return <div>Loading…</div>;
  } else {
    return (
      <div>
        {children}
      </div>
    );
  }
}


function mapStateToProps(state) {
  return {
    loading: state.loading
  };
}

export default connect(mapStateToProps)(LoadingIndicator);
