import * as React from 'react';
import {
  Box, Typography,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const FormErrorPage: React.FC<RouteComponentProps> = () => (
  <Box margin="10% auto" width="50%" minWidth={500} textAlign="center">
    <CardWithHeader title="Form Unavailable">
      <Typography>
        It is either too early or too late to access this form.
      </Typography>
    </CardWithHeader>
  </Box>
);

export default FormErrorPage;
