import * as React from 'react';
import { navigate } from '@reach/router';
import {
  Box, Button, ButtonGroup, Typography,
} from '@material-ui/core';
import { SerializedEvent } from '../../../types/Event';
import EventCards from './EventCards/EventCards';
import EventCalendar from './EventCalendar/EventCalendar';
import CardWithHeader from '../../CardWithHeader/CardWithHeader';

enum ViewType {
  Calendar = 'Calendar',
  List = 'List',
}

const EventView: React.FC = () => {
  // Fetch event cards on first render
  const [loading, setLoading] = React.useState(true);

  const [events, setEvents] = React.useState<SerializedEvent[]>([]);

  React.useEffect(() => {
    fetch('/api/events/list').then((response) => {
      if (response.ok) {
        return response;
      }
      navigate('/login');
      return response;
    }).then((response) => response.json()).then((response: SerializedEvent[]) => {
      setEvents(response);
    })
      .finally(() => setLoading(false));
  }, []);

  // Let user select view type
  const [selectedViewType, setSelectedViewType] = React.useState(ViewType.Calendar);

  // Let user know if cards are still loading
  if (loading) {
    return (
      <Typography>
        Loading...
      </Typography>
    );
  }

  // If cards are done loading but no events exist, notify
  if (!events?.length) {
    return (
      <Box margin="auto" width="50%" minWidth={500} paddingTop={1}>
        <CardWithHeader title="No Events">
          <Typography>
            No events have been created yet. Try clicking the plus icon in the bottom right!
          </Typography>
        </CardWithHeader>
      </Box>
    );
  }

  const viewButtons = Object.values(ViewType).map((name) => {
    const variant = selectedViewType === name ? 'contained' : null;
    const handleClick = (): void => setSelectedViewType(name);

    return (
      <Button variant={variant} onClick={handleClick} key={name}>
        {name}
      </Button>
    );
  });

  // Keep all views mounted (but hide appropriately) so they keep state when switching
  const eventView = (
    <>
      <Box display={selectedViewType === ViewType.List ? null : 'none'}>
        <EventCards events={events} />
      </Box>
      <Box display={selectedViewType === ViewType.Calendar ? null : 'none'}>
        <EventCalendar events={events} />
      </Box>
    </>
  );

  return (
    <>
      <Box display="flex" alignItems="center" marginBottom={1}>
        <Box marginRight={1}>
          <Typography>
            View:
          </Typography>
        </Box>
        <ButtonGroup color="secondary" size="small">
          {viewButtons}
        </ButtonGroup>
      </Box>
      {eventView}
    </>
  );
};

export default EventView;
