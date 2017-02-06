import React from 'react';
import ReactDOM from 'react-dom';
import Vs from 'Components/Vs';

console.log('AppHome');

const { gengos } = window.o6ua6;

ReactDOM.render(
  <Vs gengos={gengos} />,
  document.getElementById('content')
);
