import Api from 'Resources/Api';
import { gengoAddHistory } from 'Actions/Gengo';

class ActionDispatcher {
  constructor(dispatch) {
    this.dispatch = dispatch;
  }

  async vote(winner, loser) {
    try {
      await (new Api()).vote({ winner, loser });
      this.dispatch(gengoAddHistory({ winner, loser }));
    } catch (error) {
      // this.dispatch() // TODO: handling error to reducer
      console.error(error);
    }
  }
}

export default ActionDispatcher;
