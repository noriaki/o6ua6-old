import React, { PropTypes } from 'react';

import Gengo from 'Components/Gengo';

import styled, { keyframes } from 'styled-components';

// material-ui components
import { GridList, GridTile } from 'material-ui/GridList';

const rotateOutToLeft = keyframes`
  from {
    opacity: 1;
  }
  to {
    transform: translate3d(-100%, 0, 0) rotate3d(0, 0, 1, -120deg);
    opacity: 0.01;
  }
`;
const rotateOutToRight = keyframes`
  from {
    opacity: 1;
  }
  to {
    transform: translate3d(100%, 0, 0) rotate3d(0, 0, 1, 120deg);
    opacity: 0.01;
  }
`;
const animateDrop = (dropping, isLeft) => {
  const styles = {
    start: `
      animation-name: ${isLeft ? rotateOutToLeft : rotateOutToRight};
      animation-duration: 200ms;
      animation-fill-mode: forwards;
      animation-timing-function: ease-in-out;
    `,
    end: `
      opacity: 0.01;
    `,
  };
  return styles[dropping] || '';
};

const WrappedGridList = styled.div`
  display: flex;
  flex-wrap: wrap;
  jsutify-content: space-around;
`;

const Vs = ({ gengos, handleTouchTap, history }) => {
  const tiles = gengos.map((gengo, index) => {
    const tapTouchHandler = e =>
            handleTouchTap({ winner: gengo, gengos, history, e });
    const WrappedTile = styled.div`
      will-change: animation;
      ${animateDrop(gengo.dropping, index === 0)}
    `;
    return (
      <WrappedTile key={gengo.surface}>
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
