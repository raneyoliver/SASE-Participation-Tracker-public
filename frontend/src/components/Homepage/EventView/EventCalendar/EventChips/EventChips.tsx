import {
  Box, Chip,
} from '@material-ui/core';
import * as React from 'react';
import { SerializedEvent } from '../../../../../types/Event';
import formatTime from '../../../../../utils/formatTime';
import EventDetailsPopup from './EventDetailsPopup/EventDetailsPopup';

const chipStyle = { width: '100%', justifyContent: 'flex-start' };

interface EventChipsProps {
  events: SerializedEvent[];
}

const EventChips: React.FC<EventChipsProps> = ({ events }) => {
  const [popEvent, setPopEvent] = React.useState(null);
  const [anchorE1, setAnchorE1] = React.useState<null | HTMLElement>(null);
  const open = Boolean(anchorE1);
  const handleClose = (): void => {
    setAnchorE1(null);
  };
  const eventChips = events.map((event) => {
    const handleClick = (JSevent: React.MouseEvent<HTMLElement>): void => {
      setPopEvent(event);
      setAnchorE1(JSevent.currentTarget);
    };
    const label = `${formatTime(new Date(event.start_time))}: ${event.name}`;

    return (
      <Box paddingBottom={0.5} key={event.id}>
        <Chip style={chipStyle} color="primary" size="small" label={label} onClick={handleClick} />
      </Box>
    );
  });

  return (
    <Box overflow="auto">
      {eventChips}
      <EventDetailsPopup
        open={open}
        anchorE1={anchorE1}
        handleClose={handleClose}
        event={popEvent}
      />
    </Box>
  );
};

export default EventChips;
