import {
  START_LOSER_DROP, COMPLETE_LOSER_DROP,
} from 'Constants/ActionTypes/Animation';

describe('ActionTypes/Animation', () => {
  it('should have START_LOSER_DROP', () => {
    const expected = '/animation/START_LOSER_DROP';
    expect(START_LOSER_DROP).toEqual(expected);
  });

  it('should have COMPLETE_LOSER_DROP', () => {
    const expected = '/animation/COMPLETE_LOSER_DROP';
    expect(COMPLETE_LOSER_DROP).toEqual(expected);
  });
});
