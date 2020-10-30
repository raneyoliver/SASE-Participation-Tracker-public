import * as React from 'react';
import {
  Fab, Box, Tooltip, Typography, Button,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import { RouteComponentProps } from '@reach/router';
import ExportButton from './ExportButton/ExportButton';
import LogoutButton from './LogoutButton/LogoutButton';
import EventView from './EventView/EventView';

const Homepage: React.FC<RouteComponentProps> = () => {
  // Need to re-render the page, navigate doesn't do that
  const handleFabClick = (): void => { window.location.href = '/create_event'; };
  const handlePasswordChangeClick = (): void => { window.location.href = '/change_password'; };

  return (
    <>
      <Box textAlign="center">
        <Box display="flex" justifyContent="flex-end">
          <ExportButton id="export" />
          <Button id="change-password" color="secondary" onClick={handlePasswordChangeClick}>
            Change Password
          </Button>
          <LogoutButton id="logout" />
        </Box>
        <Typography variant="h4">
          Events
        </Typography>
      </Box>
      <EventView renderComponents />
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
