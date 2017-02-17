import React, { PropTypes } from 'react';

import Gengo from 'Components/Gengo';

import styled from 'styled-components';

// material-ui components
import { GridList, GridTile } from 'material-ui/GridList';

const VsWrapper = styled.div`
  display: flex;
  flex-wrap: wrap;
  jsutify-content: space-around;
`;

const Vs = ({ gengos, handleTouchTap, history }) => {
  const tiles = gengos.map(g => (
    <GridTile
      key={g.surface}
      onTouchTap={e => (
        handleTouchTap({ winner: g, gengos, history, e })
      )}>
      <Gengo {...g} />
    </GridTile>
  ));
  return (
    <VsWrapper>
      <GridList cellHeight="auto" padding={0}>
        {tiles}
      </GridList>
    </VsWrapper>
  );
};
Vs.propTypes = {
  gengos: PropTypes.arrayOf(PropTypes.shape(Gengo.propTypes)).isRequired,
  handleTouchTap: PropTypes.func.isRequired,
  history: PropTypes.arrayOf(
    PropTypes.arrayOf(PropTypes.shape(Gengo.propTypes))
  ).isRequired,
};

export default Vs;
