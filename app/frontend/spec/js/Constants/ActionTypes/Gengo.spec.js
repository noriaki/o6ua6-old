import {
  ADD_HISTORY, CLEAR_HISTORY, SET_STAGE, SET_OFFSTAGE,
} from 'Constants/ActionTypes/Gengo';

describe('ActionTypes/Gengo', () => {
  it('should have ADD_HISTORY', () => {
    const expected = '/gengo/ADD_HISTORY';
    expect(ADD_HISTORY).toEqual(expected);
  });

  it('should have CLEAR_HISTORY', () => {
    const expected = '/gengo/CLEAR_HISTORY';
    expect(CLEAR_HISTORY).toEqual(expected);
  });

  it('should have SET_STAGE', () => {
    const expected = '/gengo/SET_STAGE';
    expect(SET_STAGE).toEqual(expected);
  });

  it('should have SET_OFFSTAGE', () => {
    const expected = '/gengo/SET_OFFSTAGE';
    expect(SET_OFFSTAGE).toEqual(expected);
  });
});
