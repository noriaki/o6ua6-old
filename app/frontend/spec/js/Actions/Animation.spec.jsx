import {
  START_LOSER_DROP, COMPLETE_LOSER_DROP,
} from 'Constants/ActionTypes/Animation';
import {
  animationStartLoserDrop, animationCompleteLoserDrop,
} from 'Actions/Animation';

describe('Actions/Animation', () => {
  it('animationStartLoserDrop', () => {
    const value = { identifier: '1' };
    const expected = {
      type: START_LOSER_DROP,
      payload: value.identifier,
    };
    expect(animationStartLoserDrop(value.identifier)).toEqual(expected);
  });

  it('animationCompleteLoserDrop', () => {
    const value = { identifier: '1' };
    const expected = {
      type: COMPLETE_LOSER_DROP,
      payload: value.identifier,
    };
    expect(animationCompleteLoserDrop(value.identifier)).toEqual(expected);
  });
});
