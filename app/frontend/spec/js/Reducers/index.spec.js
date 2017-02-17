import { initialState as gengoInitialState } from 'Reducers/Gengo';
import rootReducers from 'Reducers';

describe('rootReducers', () => {
  it('initial state', () => {
    const expected = {
      gengo: gengoInitialState,
    };
    expect(rootReducers(undefined)).toEqual(expected);
  });
});
