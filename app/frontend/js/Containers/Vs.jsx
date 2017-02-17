import { connect } from 'react-redux';

import Vs from 'Components/Vs';
import ActionDispatcher from 'ActionDispatcher';

const mapStateToProps = state => ({
  gengos: state.gengo.stage,
});

const mapDispatchToProps = (dispatch) => {
  const dispatcher = new ActionDispatcher(dispatch);
  return {
    handleTouchTap(winner, gengos) {
      const loser = gengos.filter(g => (
        winner.identifier !== g.identifier
      ))[0];
      dispatcher.voteAndPushHistory(winner, loser);
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Vs);
