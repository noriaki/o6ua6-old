import {
  ADD_HISTORY, SET_STAGE, SET_OFFSTAGE,
} from 'Constants/ActionTypes/Gengo';
import {
  gengoAddHistory, gengoSetStage, gengoSetOffstage,
} from 'Actions/Gengo';

describe('Actions/Gengo', () => {
  it('gengoAddHistory', () => {
    const value = { winner: { id: '1' }, loser: { id: '2' } };
    const expected = {
      type: ADD_HISTORY,
      payload: value,
    };
    expect(gengoAddHistory(value)).toEqual(expected);
  });

  it('gengoSetStage', () => {
    const expected = {
      type: SET_STAGE,
    };
    expect(gengoSetStage()).toEqual(expected);
  });

  it('gengoSetOffstage', () => {
    const value = [{ id: '1' }, { id: '2' }];
    const expected = {
      type: SET_OFFSTAGE,
      payload: { left: value[0], right: value[1] },
    };
    expect(gengoSetOffstage(value)).toEqual(expected);
  });
});
