import * as React from 'react';
import { Box, Typography } from '@material-ui/core';
import { Link } from '@reach/router';
import { SerializedEvent } from '../../../../types/Event';
import formatDate from '../../../../utils/formatDate';
import CardWithHeader from '../../../CardWithHeader/CardWithHeader';

interface EventCardProps {
  event: SerializedEvent;
}

const EventCard: React.FC<EventCardProps> = ({ event }) => {
  const startTime = formatDate(new Date(event.start_time));
  const endTime = formatDate(new Date(event.end_time));

  return (
    <CardWithHeader id={`event-card-${event.id}`} title={event.name}>
      <div style={{ wordWrap: 'break-word' }}>
        <Box overflow="auto" maxHeight={120}>
          <Typography>
            {`Description: ${event.description || 'No description provided.'}`}
          </Typography>
        </Box>
        <Typography variant="body2">
          {`Starts at: ${startTime}`}
          <br />
          {`Ends at: ${endTime}`}
          <br />
          {'Sign in here: '}
          {' '}
          {event.forms.map((form) => <Link key={form.id} to={`/form/${form.id}`}>{`${form.id}`}</Link>)}
        </Typography>
      </div>
    </CardWithHeader>
  );
};

export default EventCard;
