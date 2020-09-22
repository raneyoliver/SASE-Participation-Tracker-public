import * as React from 'react';
import { Typography, Box } from '@material-ui/core';
import { SerializedEvent } from '../../../types/Event';
import EventCard from './EventCard/EventCard';

const EventCards: React.FC = () => {
  // Loading is true until fetching events is done
  const [loading, setLoading] = React.useState(true);

  // Fetch events on page load
  const [events, setEvents] = React.useState<SerializedEvent[]>([]);
  React.useEffect(() => {
    fetch('/api/events/list').then((response) => response.json()).then((response: SerializedEvent[]) => {
      setEvents(response);
      setLoading(false);
    });
  }, []);

  // Let user know if cards are still loading
  if (loading) {
    return (
      <Typography>
        Loading...
      </Typography>
    );
  }

  // Static number of columns for cards, we can change this to respond to page size later
  const numColumns = 3;
  const columnWidth = `${100 / numColumns}%`;

  const eventCards = events.map((event) => (
    <Box width={columnWidth} padding={1} boxSizing="border-box" key={event.id}>
      <EventCard event={event} />
    </Box>
  ));

  return events ? (
    <Box display="flex" flexWrap="wrap" width="100%">
      {eventCards}
    </Box>
  ) : (
    <Typography>
      No events have been created yet. Try clicking the plus icon in the bottom right!
    </Typography>
  );
};

export default EventCards;
