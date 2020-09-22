import * as React from 'react';
import {
  Box, Typography,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const ConfirmSubmissionPage: React.FC<RouteComponentProps> = () => (
  <Box margin="10% auto" width="50%" minWidth={500} textAlign="center">
    <CardWithHeader title="Thank You!">
      <Typography variant="body1">
        Your submission has been recorded. You may safely close this page.
      </Typography>
    </CardWithHeader>
  </Box>
);

export default ConfirmSubmissionPage;
