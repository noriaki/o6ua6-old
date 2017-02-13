import React from 'react';
import { render } from 'react-dom';
import injectTapEventPlugin from 'react-tap-event-plugin';
import Vs from 'Components/Vs';

// material-ui theme
import { grey700 } from 'material-ui/styles/colors';
import getMuiTheme from 'material-ui/styles/getMuiTheme';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

const muiTheme = getMuiTheme({
  palette: { accent1Color: grey700 },
});

injectTapEventPlugin();

console.log('AppHome');

const { gengos } = window.o6ua6;

const App = () => (
  <MuiThemeProvider muiTheme={muiTheme}>
    <Vs gengos={gengos} />
  </MuiThemeProvider>
);

render(
  <App />,
  document.getElementById('content')
);
