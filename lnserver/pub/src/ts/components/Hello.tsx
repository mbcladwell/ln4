
import * as React from "react";
import * as ReactDOM from "react-dom";

import {RadioGroup, Radio} from 'react-radio-group';

export interface HelloProps {
    compiler: string;
    framework: string;
}

let Hello = (props: HelloProps) =>
    <h1>Hello from {props.compiler} and {props.framework}!</h1>;

export interface RepsProps {
    replication: string;
    quad1: string;
    quad2?: string;
    quad3?: string;
    quad4?: string;
}



export {Hello, Mybuts};
