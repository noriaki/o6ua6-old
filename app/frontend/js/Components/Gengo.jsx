import React, { PropTypes } from 'react';
import styled from 'styled-components';
import Kanji from 'Components/Kanji';

const StyledGengo = styled.div`
  margin: 10px;
`;

const GengoFrame = styled.div`
  border: 4px #b2946c solid;
  width: 320px;
  height: 456px;
`;

const Gengo = ({ surface, yomi, imageUrls }) => (
  <StyledGengo>
    <GengoFrame>
      <Kanji imageUrl={imageUrls[0]} surface={surface[0]} />
      <br />
      <Kanji imageUrl={imageUrls[1]} surface={surface[1]} />
    </GengoFrame>
    <p>
      {surface}
      ({yomi.join(',')})
    </p>
  </StyledGengo>
);
Gengo.propTypes = {
  surface: PropTypes.string.isRequired,
  yomi: PropTypes.arrayOf(PropTypes.string).isRequired,
  imageUrls: PropTypes.arrayOf(PropTypes.string).isRequired,
};

export default Gengo;
