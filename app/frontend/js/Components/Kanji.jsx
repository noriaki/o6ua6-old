import React, { PropTypes } from 'react';
import styled from 'styled-components';

const SizedImage = styled.img`
width: 320px;
height: 225px;
`;

const Kanji = ({ imageUrl, surface }) => (
  <SizedImage src={imageUrl} alt={surface} />
);
Kanji.propTypes = {
  imageUrl: PropTypes.string.isRequired,
  surface: PropTypes.string.isRequired,
};

export default Kanji;
