import React from 'react';
import ReactDOM from 'react-dom';
import Vs from 'Components/Vs';

console.log('AppHome');

const gengos = [
  {
    surface: '入物',
    yomi: ['ニュウブツ'],
    imageUrls: [
      'https://o6ua6.s3.amazonaws.com/images/5a585e.jpg',
      'https://o6ua6.s3.amazonaws.com/images/9a987e.jpg',
    ],
  },
  {
    surface: '令送',
    yomi: ['レイソウ'],
    imageUrls: [
      'https://o6ua6.s3.amazonaws.com/images/4abb4e.jpg',
      'https://o6ua6.s3.amazonaws.com/images/18089e.jpg',
    ],
  },
];

ReactDOM.render(
  <Vs gengos={gengos} />,
  document.getElementById('content')
);
