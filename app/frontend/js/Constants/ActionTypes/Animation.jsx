import { createTypes } from 'redux-action-types';

export const {
  START_LOSER_DROP,
  COMPLETE_LOSER_DROP,
} = createTypes(
  '/animation/',
  'START_LOSER_DROP',
  'COMPLETE_LOSER_DROP'
);
