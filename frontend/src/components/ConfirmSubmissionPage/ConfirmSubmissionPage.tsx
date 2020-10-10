import * as React from 'react';
import {
  Typography,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const ConfirmSubmissionPage: React.FC<RouteComponentProps> = () => (
  <CardWithHeader title="Thank You!" fixWidth>
    <Typography>
      Your submission has been recorded. You may safely close this page.
    </Typography>
  </CardWithHeader>
);

export default ConfirmSubmissionPage;
