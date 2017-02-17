import { initialState as gengoInitialState } from 'Reducers/Gengo';
import rootReducers, { combineStates } from 'Reducers';

describe('rootReducers', () => {
  it('initial state', () => {
    const expected = {
      gengo: gengoInitialState,
    };
    expect(rootReducers(undefined)).toEqual(expected);
  });
});

describe('combineStatus is returning shallow merged state each keys', () => {
  const expectedState = {
    count: 3,
    history: ['a', 'b'],
    users: {
      c: { id: 1 },
      d: { id: 2 },
    },
  };

  it('add key', () => {
    const initialState = {
      history: ['a', 'b'],
      users: {
        c: { id: 1 },
        d: { id: 2 },
      },
    };
    const preloadState = { count: 3 };
    expect(combineStates(initialState, preloadState)).toEqual(expectedState);
  });

  it('override', () => {
    const initialState = {
      count: 1,
      history: ['a', 'b'],
      users: {
        c: { id: 1 },
        d: { id: 2 },
      },
    };
    const preloadState = { count: 3 };
    expect(combineStates(initialState, preloadState)).toEqual(expectedState);
  });

  it('shallow merge array', () => {
    const initialState = {
      count: 3,
      history: ['c'],
      users: {
        c: { id: 1 },
        d: { id: 2 },
      },
    };
    const preloadState = { history: ['a', 'b'] };
    expect(combineStates(initialState, preloadState)).toEqual(expectedState);
  });

  it('shallow merge array (longer array of initialState)', () => {
    const initialState = {
      count: 3,
      history: ['c', 'd', 'e'],
      users: {
        c: { id: 1 },
        d: { id: 2 },
      },
    };
    const preloadState = { history: ['a', 'b'] };
    expect(combineStates(initialState, preloadState)).toEqual(expectedState);
  });

  it('shallow merge object', () => {
    const initialState = {
      count: 3,
      history: ['a', 'b'],
      users: { c: { id: 1 } },
    };
    const preloadState = { users: { d: { id: 2 } } };
    expect(combineStates(initialState, preloadState)).toEqual(expectedState);
  });
});
