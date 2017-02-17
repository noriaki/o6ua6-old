import Api from 'Resources/Api';
import { gengoAddHistory } from 'Actions/Gengo';

class ActionDispatcher {
  constructor(dispatch, client = new Api()) {
    this.dispatch = dispatch;
    this.client = client;
  }

  async voteAndPushHistory(winner, loser) {
    try {
      await this.client.vote({ winner, loser });
      this.dispatch(gengoAddHistory({ winner, loser }));
    } catch (error) {
      // this.dispatch() // TODO: handling error to reducer
      console.error(error);
    }
  }
}

export default ActionDispatcher;
