import * as React from 'react';
import {
  Fab, Box, Tooltip, Typography,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import { RouteComponentProps } from '@reach/router';
import EventCards from './EventCards/EventCards';
import LogoutButton from './LogoutButton/LogoutButton';

const Homepage: React.SFC<RouteComponentProps> = () => {
  // Need to re-render the page, navigate doesn't do that
  const handleFabClick = (): void => { window.location.href = '/create_event'; };

  return (
    <>
      <Box textAlign="center">
        <Box display="flex" justifyContent="flex-end">
          <LogoutButton id="logout" />
        </Box>
        <Typography variant="h4">
          Events
        </Typography>
      </Box>
      <EventCards />
      <Box position="fixed" bottom={8} right={8}>
        <Tooltip title="New Event" placement="left">
          <Fab id="new-event" color="primary" size="large" onClick={handleFabClick} aria-label="create new event">
            <AddIcon />
          </Fab>
        </Tooltip>
      </Box>
    </>
  );
};

export default Homepage;
