import React, { PropTypes } from 'react';
import Kanji from 'Components/Kanji';

const style = {
  border: '4px #b2946c solid',
  width: '320px',
  height: '456px',
};

const Gengo = ({ surface, yomi, imageUrls }) => (
  <div style={{ margin: '10px' }}>
    <div className="frame" style={style}>
      <Kanji imageUrl={imageUrls[0]} />
      <br />
      <Kanji imageUrl={imageUrls[1]} />
    </div>
    <p>
      {surface}
      ({yomi.join(',')})
    </p>
  </div>
);
Gengo.propTypes = {
  surface: PropTypes.string.isRequired,
  yomi: PropTypes.arrayOf(PropTypes.string).isRequired,
  imageUrls: PropTypes.arrayOf(PropTypes.string).isRequired,
};

export default Gengo;
