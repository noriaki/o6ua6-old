import React, { PropTypes } from 'react';
import styled from 'styled-components';
import Gengo from 'Components/Gengo';

const VsWrapper = styled.div`
display: flex;
`;

const Vs = ({ gengos }) => (
  <VsWrapper>
    {gengos.map(gengo => <Gengo key={gengo.surface} {...gengo} />)}
  </VsWrapper>
);
Vs.propTypes = {
  gengos: PropTypes.arrayOf(PropTypes.shape(Gengo.propTypes)).isRequired,
};

export default Vs;
