import * as React from 'react';
import {
  Fab, Box, Tooltip, Typography,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import { RouteComponentProps, navigate } from '@reach/router';
import EventCards from './EventCards/EventCards';

const Homepage: React.SFC<RouteComponentProps> = () => {
  const handleFabClick = (): void => { navigate('/create_event'); };

  return (
    <>
      <Typography variant="h6">
        Events
      </Typography>
      <EventCards />
      <Box position="fixed" bottom={8} right={8}>
        <Tooltip title="New Event" placement="left">
          <Fab color="primary" size="large" onClick={handleFabClick} aria-label="create new event">
            <AddIcon />
          </Fab>
        </Tooltip>
      </Box>
    </>
  );
};

export default Homepage;
