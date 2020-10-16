import * as React from 'react';
import { Box, Popover, Paper } from '@material-ui/core';
import { SerializedEvent } from '../../../../../../types/Event';
import EventCard from '../../../EventCards/EventCard/EventCard';

interface EventDetailsPopupProps {
    open: boolean;
    anchorE1: HTMLElement;
    handleClose(): void;
    event: SerializedEvent;
}

const EventDetailsPopup: React.FC<EventDetailsPopupProps> = ({
  open, anchorE1, handleClose, event,
}) => (
  <div>
    <Popover
      open={open}
      anchorEl={anchorE1}
      onClose={handleClose}
      anchorOrigin={{
        vertical: 'center',
        horizontal: 'center',
      }}
      transformOrigin={{
        vertical: 'center',
        horizontal: 'center',
      }}
    >
      <Paper elevation={24}>
        <Box padding={1}>
          <EventCard event={event} />
        </Box>
      </Paper>
    </Popover>
  </div>
);

export default EventDetailsPopup;
