import React, { PropTypes } from 'react';

const style = {
  width: '320px',
  height: '225px',
};

const Kanji = ({ imageUrl }) => (
  <img src={imageUrl} alt={imageUrl} style={style} />
);
Kanji.propTypes = {
  imageUrl: PropTypes.string.isRequired,
};

export default Kanji;
