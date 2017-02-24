import { createAction } from 'redux-actions';

import {
  START_LOSER_DROP, COMPLETE_LOSER_DROP,
} from 'Constants/ActionTypes/Animation';

export const animationStartLoserDrop = createAction(
  START_LOSER_DROP, identifier => identifier);
export const animationCompleteLoserDrop = createAction(
  COMPLETE_LOSER_DROP, identifier => identifier);
