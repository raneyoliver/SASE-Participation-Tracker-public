import * as React from 'react';
import { Box, Typography } from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const EditEventErrorPage: React.FC<RouteComponentProps> = () => (
  <Box margin="10% auto" width="50%" minWidth={500} textAlign="center">
    <CardWithHeader title="Uh Oh!">
      <Typography>
        There was an issue navigating to the event you are trying to edit. Please try again.
      </Typography>
    </CardWithHeader>
  </Box>
);

export default EditEventErrorPage;
