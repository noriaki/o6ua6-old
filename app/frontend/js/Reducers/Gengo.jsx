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
  [gengoAddHistory]: (state, { payload: { winner, loser } }) => ({
    ...state, history: [...state.history, [winner, loser]],
  }),
  [gengoSetStage]: state => ({
    ...state, stage: state.offstage, offstage: [],
  }),
  [gengoSetOffstage]: (state, { payload: { left, right } }) => ({
    ...state, offstage: [left, right],
  }),
}, initialState);
