import { createTypes } from 'redux-action-types';

export const {
  ADD_HISTORY,
  CLEAR_HISTORY,
  SET_STAGE,
  SET_OFFSTAGE,
} = createTypes(
  '/gengo/',
  'ADD_HISTORY',
  'CLEAR_HISTORY',
  'SET_STAGE',
  'SET_OFFSTAGE'
);
