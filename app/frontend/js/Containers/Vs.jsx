import flatten from 'lodash/flatten';
import { connect } from 'react-redux';

import Vs from 'Components/Vs';
import { gengoSetStage } from 'Actions/Gengo';
import ActionDispatcher from 'ActionDispatcher';

const mapStateToProps = state => ({
  gengos: state.gengo.stage,
  history: state.gengo.history,
});

const mapDispatchToProps = (dispatch) => {
  const dispatcher = new ActionDispatcher(dispatch);
  return {
    handleTouchTap({ winner, gengos, history }) {
      const loser = gengos.filter(g => (
        winner.identifier !== g.identifier
      ))[0];
      Promise.all([
        dispatcher.voteAndPushHistory(winner, loser),
        dispatcher.random2SetNextStage(flatten(history)),
      ]).then(() => dispatch(gengoSetStage()));
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Vs);
