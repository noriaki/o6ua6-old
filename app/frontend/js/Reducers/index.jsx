import isPlainObject from 'lodash/isPlainObject';
import flatten from 'lodash/flatten';
import compact from 'lodash/compact';
import { combineReducers } from 'redux';
import better from 'better-combine-reducers';

import gengoReducers, { initialState as gengoInitialState } from './Gengo';

export const combineStates = (initialState, ...preloadStates) => {
  const combinedKeys = compact([
    ...Object.keys(initialState),
    ...flatten(preloadStates.map(Object.keys)),
  ]);
  return preloadStates.reduce((finalState, preloadState) => {
    combinedKeys.forEach((key) => {
      /* eslint-disable no-param-reassign */
      if (isPlainObject(finalState[key]) && isPlainObject(preloadState[key])) {
        finalState[key] = { ...finalState[key], ...preloadState[key] };
      } else if (preloadState[key] !== undefined) {
        if (finalState[key] === undefined) {
          /* WARN: Key(${key}) should be defined as the initial state */
        }
        finalState[key] = preloadState[key];
      }
      /* eslint-enable no-param-reassign */
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
