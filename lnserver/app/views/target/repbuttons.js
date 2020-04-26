'use strict';

import React from 'react';
import ReactDOM from 'react-dom';
import {RadioGroup, Radio} from '../index.jsx';

let App = React.createClass({
  getInitialState() {
    return {selectedValue: 'singlicates'};
  },

  handleChange(value) {
    this.setState({selectedValue: value});
  },

  render() {
    return (
	    <RadioGroup name="replication"
	selectedValue={this.state.selectedValue}
	onChange={this.handleChange}>
	    <label>  <Radio value="singlicates" />Singlicates</label>
	    <label>  <Radio value="duplicates" />Duplicates</label>
	    <label>  <Radio value="quadruplicates" />Quadruplicates</label>
	    </RadioGroup>
    );
  }
});

ReactDOM.render(<App />, document.getElementById('singlicates'));
