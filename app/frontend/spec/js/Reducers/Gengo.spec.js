import {
  gengoAddHistory,
  gengoClearHistory,
  gengoSetStage,
  gengoSetOffstage,
} from 'Actions/Gengo';
import {
  animationStartLoserDrop,
  animationCompleteLoserDrop,
} from 'Actions/Animation';

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

  it('set dropping to "start"', () => {
    const value = [{ identifier: '1' }, { identifier: '2' }];
    const expected = {
      ...initialState,
      stage: [value[0], { ...value[1], dropping: 'start' }],
    };
    expect(
      gengoReducers(
        { ...initialState, stage: value },
        animationStartLoserDrop(value[1].identifier)
      )
    ).toEqual(expected);
  });

  it('set dropping to "end"', () => {
    const value = [{ identifier: '1' }, { identifier: '2', dropping: 'start' }];
    const expected = {
      ...initialState,
      stage: [value[0], { ...value[1], dropping: 'end' }],
    };
    expect(
      gengoReducers(
        { ...initialState, stage: value },
        animationCompleteLoserDrop(value[1].identifier)
      )
    ).toEqual(expected);
  });
});
