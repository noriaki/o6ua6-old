import Api from 'Resources/Api';

describe('Resources/Api', () => {
  let spy;
  let api;
  beforeEach(() => {
    spy = {
      post: jest.fn().mockReturnThis(),
      set: jest.fn().mockReturnThis(),
      type: jest.fn().mockReturnThis(),
      accept: jest.fn().mockReturnThis(),
      send: jest.fn().mockReturnThis(),
    };
    api = new Api(spy);
  });

  it('#vote', () => {
    const value = { winner: { identifier: 1 }, loser: { identifier: 2 } };
    api.vote(value);
    expect(spy.post).toBeCalledWith('/vote');
    expect(spy.type).toBeCalledWith('json');
    expect(spy.accept).toBeCalledWith('json');
    expect(spy.send).toBeCalledWith({
      data: `${value.winner.identifier}/${value.loser.identifier}`,
    });
  });
});
