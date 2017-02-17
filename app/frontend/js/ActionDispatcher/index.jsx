import Api from 'Resources/Api';
import { gengoAddHistory, gengoSetOffstage } from 'Actions/Gengo';

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

  async random2SetNextStage(excepts = []) {
    try {
      const gengos = await this.client.random({ limit: 2, excepts });
      this.dispatch(gengoSetOffstage(gengos));
    } catch (error) {
      // this.dispatch() // TODO: handling error to reducer
      console.error(error);
    }
  }
}

export default ActionDispatcher;
