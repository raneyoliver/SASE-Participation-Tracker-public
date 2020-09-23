import * as React from 'react';
import {
  Box, Typography,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const FormErrorPage: React.FC<RouteComponentProps> = () => (
  <Box margin="10% auto" width="50%" minWidth={500} textAlign="center">
    <CardWithHeader title="Uh Oh!">
      <Typography>
        There was an issue navigating to your form. Please try again.
      </Typography>
    </CardWithHeader>
  </Box>
);

export default FormErrorPage;
