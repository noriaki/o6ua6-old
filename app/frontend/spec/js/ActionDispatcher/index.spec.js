import ActionDispatcher from 'ActionDispatcher';
import { gengoAddHistory } from 'Actions/Gengo';

describe('ActionDispatcher', () => {
  let dispatch;
  let client;
  let dispatcher;
  beforeEach(() => {
    dispatch = jest.fn();
    client = {
      vote: jest.fn(() => Promise.resolve()),
    };
    dispatcher = new ActionDispatcher(dispatch, client);
  });

  describe('#vote', () => {
    let value;
    beforeEach(() => {
      value = { winner: 1, loser: 2 };
    });

    it('returning Promise object', () => {
      const subject = dispatcher.vote(value.winner, value.loser);
      expect(typeof subject.then).toBe('function');
    });

    it('calling client#vote', async () => {
      await dispatcher.vote(value.winner, value.loser);
      expect(client.vote).toBeCalledWith(value);
    });

    it('calling dispatch with redux action object', async () => {
      await dispatcher.vote(value.winner, value.loser);
      expect(dispatch).toHaveBeenCalledWith(gengoAddHistory(value));
    });
  });
});
