import * as React from 'react';
import {
  Typography,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const ConfirmUpdatePage: React.FC<RouteComponentProps> = () => (
  <CardWithHeader title="Thank You!" fixWidth>
    <Typography>
      Your previous submission has been updated. You may safely close this page.
    </Typography>
  </CardWithHeader>
);

export default ConfirmUpdatePage;
