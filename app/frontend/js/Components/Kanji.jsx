import React, { PropTypes } from 'react';
import styled from 'styled-components';

const SizedImage = styled.img`
position: relative;
left: 50%;
transform: translateX(-50%);
height: 100%;
width: 100%;
`;

const Kanji = ({ imageUrl, surface }) => (
  <SizedImage src={imageUrl} alt={surface} />
);
Kanji.propTypes = {
  imageUrl: PropTypes.string.isRequired,
  surface: PropTypes.string.isRequired,
};

export default Kanji;
