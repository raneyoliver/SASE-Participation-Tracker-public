import * as React from 'react';
import {
  Box, Typography, Button,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import EventView from '../Homepage/EventView/EventView';

const ViewEventsPage: React.FC<RouteComponentProps> = () => {
  // Need to re-render the page, navigate doesn't do that
  const handleLoginClick = (): void => { window.location.href = '/login'; };
  const handleHelpClick = (): void => { window.location.href = '/help'; };

  return (
    <>
      <Box textAlign="center">
        <Box display="flex" justifyContent="flex-end">
          <Button id="help" color="secondary" onClick={handleHelpClick}>
            Help
          </Button>
          <Button id="login" variant="contained" color="secondary" onClick={handleLoginClick}>
            Log In
          </Button>
        </Box>
        <Typography variant="h4">
          Events
        </Typography>
      </Box>
      <EventView renderComponents={false} />
    </>
  );
};

export default ViewEventsPage;
