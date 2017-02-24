import ActionDispatcher from 'ActionDispatcher';
import { gengoAddHistory, gengoSetOffstage } from 'Actions/Gengo';
import { animationStartLoserDrop } from 'Actions/Animation';

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

  describe('#random2SetNextStage', () => {
    const mockApiResponse = [{ identifier: '1' }, { identifier: '2' }];
    beforeEach(() => {
      client.random = jest.fn(() => Promise.resolve(mockApiResponse));
    });
    it('returning Promise object', () => {
      const subject = dispatcher.random2SetNextStage();
      expect(typeof subject.then).toBe('function');
    });

    it('calling client#random', async () => {
      await dispatcher.random2SetNextStage(
        [{ identifier: '3' }, { identifier: '4' }]
      );
      expect(client.random).toBeCalledWith({ limit: 2, excepts: ['3', '4'] });
    });

    it('calling dispatch with redux action [SET_OFFSTAGE]', async () => {
      await dispatcher.random2SetNextStage();
      expect(dispatch).toHaveBeenCalledWith(gengoSetOffstage(mockApiResponse));
    });
  });

  describe('#animateLoserDrop', () => {
    const target = {};
    beforeEach(() => {
      target.addEventListener = jest.fn((_, listener) => { listener(); });
      target.removeEventListener = jest.fn();
    });
    it('returning Promise object', () => {
      const subject = dispatcher.animateLoserDrop({ identifier: '1' }, target);
      expect(typeof subject.then).toBe('function');
    });

    it('calling target#{add,remove}EventListener', async () => {
      await dispatcher.animateLoserDrop({ identifier: '1' }, target);
      expect(target.addEventListener).toHaveBeenCalled();
      expect(target.removeEventListener).toHaveBeenCalled();
    });

    it('calling dispatch with redux action [START_LOSER_DROP]', async () => {
      const value = { identifier: '1' };
      await dispatcher.animateLoserDrop(value, target);
      expect(dispatch).toHaveBeenCalledWith(
        animationStartLoserDrop(value.identifier)
      );
    });
  });
});
