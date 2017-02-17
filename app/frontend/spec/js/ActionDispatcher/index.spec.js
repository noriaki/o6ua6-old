import ActionDispatcher from 'ActionDispatcher';
import { gengoAddHistory } from 'Actions/Gengo';

describe('ActionDispatcher', () => {
  let dispatch;
  let client;
  let dispatcher;
  beforeEach(() => {
    dispatch = jest.fn();
    client = {};
    dispatcher = new ActionDispatcher(dispatch, client);
  });

  describe('#voteAndPushHistory', () => {
    let value;
    beforeEach(() => {
      value = { winner: 1, loser: 2 };
      client.vote = jest.fn(() => Promise.resolve());
    });

    it('returning Promise object', () => {
      const subject = dispatcher.voteAndPushHistory(value.winner, value.loser);
      expect(typeof subject.then).toBe('function');
    });

    it('calling client#vote', async () => {
      await dispatcher.voteAndPushHistory(value.winner, value.loser);
      expect(client.vote).toBeCalledWith(value);
    });

    it('calling dispatch with redux action [ADD_HISTORY]', async () => {
      await dispatcher.voteAndPushHistory(value.winner, value.loser);
      expect(dispatch).toHaveBeenCalledWith(gengoAddHistory(value));
    });
  });
});
