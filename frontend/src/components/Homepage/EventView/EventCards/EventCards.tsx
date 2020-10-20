import * as React from 'react';
import { Typography, Box } from '@material-ui/core';
import { SerializedEvent } from '../../../../types/Event';
import EventCard from './EventCard/EventCard';
import CardWithHeader from '../../../CardWithHeader/CardWithHeader';
import EventSortButtons from '../EventSortButtons/EventSortButtons';

interface EventCardsProps {
  events: SerializedEvent[];
}

const EventCards: React.FC<EventCardsProps> = ({ events: initialEvents }) => {
  const [events, setEvents] = React.useState(initialEvents);
  const handleEventSort = React.useCallback((newEvents: SerializedEvent[]): void => {
    setEvents(newEvents);
  }, []);

  // Static number of columns for cards, we can change this to respond to page size later
  const numColumns = 3;
  const columnWidth = `${100 / numColumns}%`;

  const eventCards = events.map((event) => (
    <Box width={columnWidth} padding={1} boxSizing="border-box" key={event.id}>
      <EventCard event={event} />
    </Box>
  ));

  const sortButtons = events ? <EventSortButtons events={events} variant="cards" onSort={handleEventSort} /> : null;

  const cardList = events?.length ? (
    eventCards
  ) : (
    <Box margin="auto" width="50%" minWidth={500} paddingTop={1}>
      <CardWithHeader title="No Events">
        <Typography>
          No events match your criteria.
        </Typography>
      </CardWithHeader>
    </Box>
  );

  return (
    <>
      {sortButtons}
      <Box display="flex" flexWrap="wrap" width="100%">
        {cardList}
      </Box>
    </>
  );
};

export default EventCards;
