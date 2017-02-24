import Api from 'Resources/Api';
import { gengoAddHistory, gengoSetOffstage } from 'Actions/Gengo';
import {
  animationStartLoserDrop, animationCompleteLoserDrop,
} from 'Actions/Animation';

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

  async random2SetNextStage(history = []) {
    try {
      const excepts = history.map(g => g.identifier);
      const gengos = await this.client.random({ limit: 2, excepts });
      this.dispatch(gengoSetOffstage(gengos));
    } catch (error) {
      // this.dispatch() // TODO: handling error to reducer
      console.error(error);
    }
  }

  animateLoserDrop(loser, target = document) {
    return new Promise((resolve, reject) => {
      const handler = () => {
        this.dispatch(animationCompleteLoserDrop(loser.identifier));
        target.removeEventListener('animationend', handler, false);
        resolve();
      };
      target.addEventListener('animationend', handler, false);
      this.dispatch(animationStartLoserDrop(loser.identifier));
      setTimeout(() => { reject(); }, 3000);
    });
  }
}

export default ActionDispatcher;
