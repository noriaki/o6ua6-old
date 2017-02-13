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

const Vs = ({ gengos }) => (
  <VsWrapper>
    <GridList cellHeight="auto" padding={0}>
      {gengos.map(gengo => (
        <GridTile key={gengo.surface} onTouchTap={e => console.log('tap', e)}>
          <Gengo {...gengo} />
        </GridTile>
      ))}
    </GridList>
  </VsWrapper>
);
Vs.propTypes = {
  gengos: PropTypes.arrayOf(PropTypes.shape(Gengo.propTypes)).isRequired,
};

export default Vs;
