import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import injectTapEventPlugin from 'react-tap-event-plugin';
import configureStore from 'Store';
import Vs from 'Containers/Vs';

// material-ui theme
import { grey700 } from 'material-ui/styles/colors';
import getMuiTheme from 'material-ui/styles/getMuiTheme';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

const muiTheme = getMuiTheme({
  palette: { accent1Color: grey700 },
});

injectTapEventPlugin();

console.log('AppHome');

const { gengos, history } = window.o6ua6;

const store = configureStore({ gengo: { stage: gengos, history } });

render(
  <MuiThemeProvider muiTheme={muiTheme}>
    <Provider store={store}>
      <Vs />
    </Provider>
  </MuiThemeProvider>,
  document.getElementById('content')
);
