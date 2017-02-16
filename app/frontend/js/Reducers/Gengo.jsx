import { handleActions } from 'redux-actions';

import {
  gengoAddHistory,
  gengoSetStage,
  gengoSetOffstage,
} from 'Actions/Gengo';

export const initialState = {
  offstage: [],
  stage: [],
  history: [],
};

export default handleActions({
  [gengoAddHistory]: (state = initialState, { payload: { winner, loser } = {} }) => ({
    ...state, history: [...state.history, [winner, loser]],
  }),
  [gengoSetStage]: (state = initialState, { payload: { left, right } = {} }) => ({
    ...state, offstage: [], stage: [left, right],
  }),
  [gengoSetOffstage]: (state = initialState, { payload: { left, right } = {} }) => ({
    ...state, offstage: [left, right],
  }),
}, initialState);
