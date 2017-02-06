import React, { PropTypes } from 'react';
import Gengo from 'Components/Gengo';

const Vs = ({ gengos }) => (
  <div className="vs" style={{ display: 'flex' }}>
    {gengos.map(gengo => <Gengo key={gengo.surface} {...gengo} />)}
  </div>
);
Vs.propTypes = {
  gengos: PropTypes.arrayOf(PropTypes.shape(Gengo.propTypes)).isRequired,
};

export default Vs;
