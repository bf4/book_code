import React from 'react'

class CheckPayType extends React.Component {
  render() {
    return (
      <div>
        <div className="field">
          <label htmlFor="order_routing_number">Routing #</label>
          <input type="password"
                 name="order[routing_number]" 
                 id="order_routing_number" />
        </div>
        <div className="field">
          <label htmlFor="order_account_number">Account #</label>
          <input type="text"
                 name="order[account_number]" 
                 id="order_account_number" />
        </div>
      </div>
    );
  }
}
export default CheckPayType
