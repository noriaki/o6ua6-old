import { combineReducers } from 'redux';
import better from 'better-combine-reducers';

import gengoReducers, { initialState as gengoInitialState } from './Gengo';

export const combineStates = (initialState, ...preloadStates) => {
  const combinedKeys = Object.keys(initialState);
  return preloadStates.reduce((finalState, preloadState) => {
    combinedKeys.forEach((key) => {
      // eslint-disable-next-line no-param-reassign
      finalState[key] = { ...finalState[key], ...preloadState[key] };
    });
    return finalState;
  }, initialState);
};

export default better(combineReducers)(
  {
    gengo: gengoReducers,
  }, {
    gengo: gengoInitialState,
  }
);
