import * as React from 'react';
import {
  Box, Typography,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

interface TextBoxPageProps extends RouteComponentProps {
  title: string;
  text: string;
}

const TextBoxPage: React.FC<TextBoxPageProps> = ({ title, text }) => (
  <Box margin="10% auto" width="50%" minWidth={500} textAlign="center">
    <CardWithHeader title={title}>
      <Typography>
        { text }
      </Typography>
    </CardWithHeader>
  </Box>
);

export default TextBoxPage;
