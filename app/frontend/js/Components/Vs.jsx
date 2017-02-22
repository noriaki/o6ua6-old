import React, { PropTypes } from 'react';

import Gengo from 'Components/Gengo';

import styled, { keyframes } from 'styled-components';

// material-ui components
import { GridList, GridTile } from 'material-ui/GridList';

const animateDrop = (dropping) => {
  const fadeIn = keyframes`
    0% {
        opacity: 1;
    }
    100% {
        opacity: 0;
    }
  `;
  return dropping ? `
    animation-name: ${fadeIn};
    animation-duration: 200ms;
    animation-fill-mode: both;
  ` : '';
};

const WrappedGridList = styled.div`
  display: flex;
  flex-wrap: wrap;
  jsutify-content: space-around;
`;

const Vs = ({ gengos, handleTouchTap, history }) => {
  const tiles = gengos.map((gengo) => {
    const tapTouchHandler = e =>
            handleTouchTap({ winner: gengo, gengos, history, e });
    const animationEndHandler = e => console.log(e);
    const WrappedTile = styled.div`
        ${animateDrop(gengo.dropping)}
    `;
    return (
      <WrappedTile key={gengo.surface} onAnimationEnd={animationEndHandler}>
        <GridTile onTouchTap={tapTouchHandler}>
          <Gengo {...gengo} />
        </GridTile>
      </WrappedTile>
    );
  });
  return (
    <WrappedGridList>
      <GridList cellHeight="auto">
        {tiles}
      </GridList>
    </WrappedGridList>
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
