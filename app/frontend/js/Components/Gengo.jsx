import React, { PropTypes } from 'react';
import Kanji from 'Components/Kanji';

const Gengo = ({ surface, imageUrls }) => (
  <a href="javascript:void(0)">
    <Kanji imageUrl={imageUrls[0]} surface={surface[0]} />
    <Kanji imageUrl={imageUrls[1]} surface={surface[1]} />
  </a>
);
Gengo.propTypes = {
  surface: PropTypes.string.isRequired,
  imageUrls: PropTypes.arrayOf(PropTypes.string).isRequired,
};

export default Gengo;
