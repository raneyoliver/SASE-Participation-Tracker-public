import * as React from 'react';
import { Typography, Box } from '@material-ui/core';
import { navigate } from '@reach/router';
import { SerializedEvent } from '../../../types/Event';
import EventCard from './EventCard/EventCard';
import CardWithHeader from '../../CardWithHeader/CardWithHeader';
import EventSortButtons from './EventSortButtons/EventSortButtons';

interface RenderProps {
  renderComponents: boolean;
}

const EventCards: React.FC<RenderProps> = ({ renderComponents }) => {
  // Loading is true until fetching events is done
  const [loading, setLoading] = React.useState(true);

  const [events, setEvents] = React.useState<SerializedEvent[]>([]);
  const [hasEvents, setHasEvents] = React.useState(false);

  React.useEffect(() => {
    fetch('/api/events/list').then((response) => {
      if (response.ok) {
        return response;
      }
      navigate('/view_events');
      return response;
    }).then((response) => response.json()).then((response: SerializedEvent[]) => {
      setHasEvents(Boolean(response.length));
      setEvents(response);
    })
      .finally(() => setLoading(false));
  }, []);

  const handleEventSort = React.useCallback((newEvents: SerializedEvent[]): void => {
    setEvents(newEvents);
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
      <EventCard event={event} renderComponents={renderComponents} />
    </Box>
  ));

  const sortButtons = events ? <EventSortButtons events={events} onSort={handleEventSort} /> : null;

  const nonePresentText = hasEvents ? (
    'No events match your criteria.'
  ) : (
    'No events have been created yet. Try clicking the plus icon in the bottom right!'
  );

  const cardList = events?.length ? (
    eventCards
  ) : (
    <CardWithHeader title="No Events">
      <Typography>
        {nonePresentText}
      </Typography>
    </CardWithHeader>
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
