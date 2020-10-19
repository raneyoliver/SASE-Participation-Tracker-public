import { Box, Chip } from '@material-ui/core';
import * as React from 'react';
import { SerializedEvent } from '../../../../../types/Event';
import formatTime from '../../../../../utils/formatTime';

const chipStyle = { width: '100%', justifyContent: 'flex-start' };

interface EventChipsProps {
  events: SerializedEvent[];
}

const EventChips: React.FC<EventChipsProps> = ({ events }) => {
  const eventChips = events.map((event) => {
    const handleClick = (): void => {
      // TODO: open card for event on click
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
    </Box>
  );
};

export default EventChips;
