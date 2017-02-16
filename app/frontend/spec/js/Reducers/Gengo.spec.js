import {
  gengoAddHistory,
  gengoSetStage,
  gengoSetOffstage,
} from 'Actions/Gengo';
import gengoReducers, { initialState } from 'Reducers/Gengo';

describe('Reducers/Gengo', () => {
  it('add history', () => {
    const value = [{ id: '1' }, { id: '2' }];
    const expected = { ...initialState, history: [value] };
    expect(
      gengoReducers(
        undefined,
        gengoAddHistory({ winner: value[0], loser: value[1] })
      )
    ).toEqual(expected);
  });

  it('set stage and purge offstage', () => {
    const value = [{ id: '1' }, { id: '2' }];
    const expected = { ...initialState, stage: value };
    expect(
      gengoReducers(
        { ...initialState, offstage: [{ id: '3' }] },
        gengoSetStage(value)
      )
    ).toEqual(expected);
  });

  it('set offstage', () => {
    const value = [{ id: '1' }, { id: '2' }];
    const expected = { ...initialState, offstage: value };
    expect(
      gengoReducers(
        undefined,
        gengoSetOffstage(value)
      )
    ).toEqual(expected);
  });
});
