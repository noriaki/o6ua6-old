import { handleActions } from 'redux-actions';

import {
  gengoAddHistory,
  gengoClearHistory,
  gengoSetStage,
  gengoSetOffstage,
} from 'Actions/Gengo';
import {
  animationStartLoserDrop,
  animationCompleteLoserDrop,
} from 'Actions/Animation';

export const initialState = {
  offstage: [],
  stage: [],
  history: [],
};

export default handleActions({
  [gengoAddHistory]: (state, { payload: { winner, loser } }) => ({
    ...state, history: [...state.history, [winner, loser]],
  }),
  [gengoClearHistory]: state => ({
    ...state, history: [],
  }),
  [gengoSetStage]: state => ({
    ...state, stage: state.offstage, offstage: [],
  }),
  [gengoSetOffstage]: (state, { payload: { left, right } }) => ({
    ...state, offstage: [left, right],
  }),
  [animationStartLoserDrop]: (state, { payload: identifier }) => {
    const stage = state.stage.map(gengo => (
      gengo.identifier === identifier ?
        { ...gengo, dropping: 'start' } : gengo
    ));
    return { ...state, stage };
  },
  [animationCompleteLoserDrop]: (state, { payload: identifier }) => {
    const stage = state.stage.map(gengo => (
      gengo.identifier === identifier ?
        { ...gengo, dropping: 'end' } : gengo
    ));
    return { ...state, stage };
  },
}, initialState);
