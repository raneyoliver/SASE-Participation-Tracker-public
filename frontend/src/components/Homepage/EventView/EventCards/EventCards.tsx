import * as React from 'react';
import { Typography, Box, Grid } from '@material-ui/core';
import { SerializedEvent } from '../../../../types/Event';
import EventCard from './EventCard/EventCard';
import CardWithHeader from '../../../CardWithHeader/CardWithHeader';
import EventSortButtons from '../EventSortButtons/EventSortButtons';

interface EventCardsProps {
  events: SerializedEvent[];
  renderComponents: boolean;
}

// eslint-disable-next-line max-len
const EventCards: React.FC<EventCardsProps> = ({ events: initialEvents, renderComponents: render }) => {
  const [events, setEvents] = React.useState(initialEvents);
  const handleEventSort = React.useCallback((newEvents: SerializedEvent[]): void => {
    setEvents(newEvents);
  }, []);

  const eventCards = events.map((event) => (
    <Grid key={event.id} item xs={4}>
      <EventCard event={event} renderComponents={render} />
    </Grid>
  ));

  const sortButtons = events ? <EventSortButtons events={events} variant="cards" onSort={handleEventSort} /> : null;

  const cardList = events?.length ? (
    <Grid container spacing={2}>
      {eventCards}
    </Grid>
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
      {cardList}
    </>
  );
};

export default EventCards;
