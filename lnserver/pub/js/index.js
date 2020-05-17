import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import {RadioGroup, Radio} from 'react-radio-group';
import Select from 'react-select';


//https://react.tips/radio-buttons-in-react-16/   id": "react@16.13.1",
// https://getbootstrap.com/docs/4.2/layout/grid/
// https://react.tips/dropdowns-in-react-16/
// https://medium.com/@kellyharrop/react-for-dummies-c56a94063bfe
function makeElement(s){
   // return '{ "value":' + '"' +  s + '","label":' + '"' + s + '"}'
    return { value:  "" + s + "",  label:  "" +  s + ""   }
}

const options = document.getElementById('ddcontent2').getAttribute("data").split(' ').map(x => makeElement(x));


class CreateTargetLayout extends React.Component {
    constructor(props) {
	super(props);
	this.state = {
	    selectedRadioValue: 'singlicates',
	    q1isDisabled: false,
	    q2isDisabled: false,
	    q3isDisabled: false,
	    q4isDisabled: false,
	    q1placeholder: "Select...",
	    q2placeholder: "Select...",
	    q3placeholder: "Select...",
	    q4placeholder: "Select...",
	    q1value: "",
	    q2value: "",
	    q3value: "",
	    q4value: "",
	
	};
    };

    handleQ2Value = q2value => {
	this.setState({
	    q2value
	});
    };

        handleQ3Value = q3value => {
	this.setState({
	    q3value
	});
    };

        handleQ4Value = q4value => {
	this.setState({
	    q4value
	});
    };


    handleQ1Value = q1value => {
	
	    this.setState({ q1value });
	
    };
    
        handleRadioChange = selectedRadioValue => {
	this.setState({
	    selectedRadioValue
	});
	    switch(selectedRadioValue) {
	    case "singlicates":
		console.log("You have clicked sing");		
		this.setState({q1isDisabled: false});
		this.setState({q1placeholder: "Select..."});
		this.setState({q2isDisabled: false});
		this.setState({q2placeholder: "Select..."});
		this.setState({q3isDisabled: false});
		this.setState({q3placeholder: "Select..."});
		this.setState({q4isDisabled: false});
		this.setState({q4placeholder: "Select..."});
		break;
	    case "duplicates":
		console.log("You have clicked dups");
		this.setState({q1isDisabled: false});
		this.setState({q1placeholder: "Select..."});
		this.setState({q2isDisabled: false});
		this.setState({q2placeholder: "Select..."});
		this.setState({q3isDisabled: true});
		this.setState({q3placeholder: "--Disabled--"});
		this.setState({q4isDisabled: true});
		this.setState({q4placeholder: "--Disabled--"});
		break;
	    case "quadruplicates":
		console.log("You have clicked quad");
		this.setState({q1isDisabled: false});
		this.setState({q1placeholder: "Select..."});
		this.setState({q2isDisabled: true});
		this.setState({q2placeholder: "--Disabled--"});
		this.setState({q3isDisabled: true});
		this.setState({q3placeholder: "--Disabled--"});
		this.setState({q4isDisabled: true});
		this.setState({q4placeholder: "--Disabled--"});
		break;
	    default :
		console.log("Error in switch statement!")
	    } 
	};
    

    
handleFormSubmit = formSubmitEvent => {
  formSubmitEvent.preventDefault();
      console.log("You have submitted: ", this.state.q1value, " ",this.state.q2value, " ",this.state.q3value, " ",this.state.q4value, " " );

};
  
//https://stackoverflow.com/questions/27784212/how-to-use-radio-buttons-in-reactjs
    render() {
	// const { selectedRadioValue } = this.state;
		 const { q1value } = this.state;
	 const { q2value } = this.state;
	 const { q3value } = this.state;
	 const { q4value } = this.state;
	const { q1isDisabled } = this.state;
	const { q2isDisabled } = this.state;
	const { q3isDisabled } = this.state;
	const { q4isDisabled } = this.state;
	const { q1placeholder } = this.state;
	const { q2placeholder } = this.state;
	const { q3placeholder } = this.state;
	const { q4placeholder } = this.state;


	return (
		<div>
		<h2 className="mb-4">1: Select level of replication</h2>
		<form onSubmit={this.handleFormSubmit}>
		<div>
		
		<RadioGroup
            name="replication"
            selectedValue={this.state.selectedRadioValue}
            onChange={this.handleRadioChange}>
		<label>
		<Radio value="singlicates" />Singlicates
            </label>
		<label>
		<Radio value="duplicates" />Duplicates
            </label>
		<label>
		<Radio value="quadruplicates" />Quadruplicates
            </label>
		</RadioGroup>
		</div>

		<div>
		<h2 className="mb-4">2: Assign targets to quadrants</h2>

	    
		<div className="form-group" >
                <label htmlFor="q1">Quadrant 1</label>
                <Select
            value={q1value}
            onChange={this.handleQ1Value}
            name="form-control"
	placeholder = {q1placeholder}
            options={options}
	    isDisabled= {q1isDisabled}
                >
                </Select>
		</div>
                 
               
              <div className="form-group">
                <label htmlFor="q2">Quadrant 2</label>
                <Select
                  value={q2value}
	placeholder = {q2placeholder}
                  onChange={this.handleQ2Value}
            className="form-control"
	    options={options}
	    isDisabled={q2isDisabled}
                >
                </Select>
		</div>
                 
               
              <div className="form-group" >
                <label htmlFor="q3">Quadrant 3</label>
                <Select
                  value={q3value}
                  onChange={this.handleQ3Value}
	placeholder = {q3placeholder}
            name="form-control"
            options={options}
	    isDisabled= {q3isDisabled}
                >
		}
                </Select>
		</div>
                 
               
              <div className="form-group" >
                <label htmlFor="q4">Quadrant 4</label>
                <Select
        value={q4value}
	placeholder = {q4placeholder}
                  onChange={this.handleQ4Value}
            name="form-control"
            options={options}
	isDisabled= {q4isDisabled}
                >
                </Select>
		</div>


	    
	    <div>
	    <h2 className="mb-4">3: </h2>
                <button className="btn btn-primary mt-2" type="submit">Submit
            </button>
		</div>
</div>
		</form>
		</div>
		);
    }
}


// ========================================

ReactDOM.render(
	<CreateTargetLayout  />,
    document.getElementById('root')
);

