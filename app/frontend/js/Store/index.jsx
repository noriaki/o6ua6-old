import { createStore } from 'redux';
import { devToolsEnhancer } from 'redux-devtools-extension';

import rootReducer, { combineStates } from 'Reducers';

export default function configureStore(preloadState = {}) {
  const initialState = rootReducer();
  const finalState = combineStates(initialState, preloadState);
  const store = createStore(
    rootReducer,
    finalState,
    devToolsEnhancer()
  );
  return store;
}
