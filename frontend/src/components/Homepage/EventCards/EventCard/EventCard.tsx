import * as React from 'react';
import { Box, Typography } from '@material-ui/core';
import { SerializedEvent } from '../../../../types/Event';
import formatDate from '../../../../utils/formatDate';
import CardWithHeader from '../../../CardWithHeader/CardWithHeader';

interface EventCardProps {
  event: SerializedEvent;
}

const EventCard: React.FC<EventCardProps> = ({ event }) => {
  const startTime = formatDate(new Date(event.start_time));
  const endTime = formatDate(new Date(event.start_time));
  const sign_in_link = event.sign_in_link;

  return (
    <CardWithHeader title={event.name}>
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
          {`Sign in here: ${event.forms.map((form) => form.id).join(', ')}`}
        </Typography>
      </div>
    </CardWithHeader>
  );
};

export default EventCard;
