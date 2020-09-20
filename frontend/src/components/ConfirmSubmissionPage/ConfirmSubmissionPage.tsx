import * as React from 'react';
import {
  Card, CardHeader, CardContent, Box, Typography
} from '@material-ui/core';
import { SASEBlue } from '../../theme';
import { RouteComponentProps } from '@reach/router';
import { borders } from '@material-ui/system';
import { useTheme } from '@material-ui/styles';

const ConfirmSubmissionPage: React.FC<RouteComponentProps> = () => (


  <Box margin="10% auto" width="50%" minWidth={500}>
    <Card>
      <Box bgcolor={SASEBlue} color="white" textAlign="center">
        <CardHeader title="Thank You!" />
      </Box>
      <CardContent>
        <Box textAlign="center">
          <Typography variant="body1">
            Your submission has been recorded. You may safely close this page.
          </Typography>
        </Box>
      </CardContent>
    </Card>
  </Box>
);

export default ConfirmSubmissionPage;