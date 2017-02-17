import { createAction } from 'redux-actions';

import {
  ADD_HISTORY,
  SET_STAGE,
  SET_OFFSTAGE,
} from 'Constants/ActionTypes/Gengo';

export const gengoAddHistory = createAction(
  ADD_HISTORY, ({ winner, loser }) => ({ winner, loser }));
export const gengoSetStage = createAction(SET_STAGE);
export const gengoSetOffstage = createAction(
  SET_OFFSTAGE, gengos => ({ left: gengos[0], right: gengos[1] })
);
