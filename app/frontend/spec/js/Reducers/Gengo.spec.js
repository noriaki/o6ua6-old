import {
  gengoAddHistory,
  gengoClearHistory,
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

  it('purge history', () => {
    const value = [{ id: '1' }, { id: '2' }];
    const expected = { ...initialState };
    expect(
      gengoReducers(
        { ...initialState, history: [value] },
        gengoClearHistory()
      )
    ).toEqual(expected);
  });

  it('move offstage to stage (purge offstage)', () => {
    const value = [{ id: '1' }, { id: '2' }];
    const expected = { ...initialState, stage: value };
    expect(
      gengoReducers(
        { ...initialState, offstage: value },
        gengoSetStage()
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
