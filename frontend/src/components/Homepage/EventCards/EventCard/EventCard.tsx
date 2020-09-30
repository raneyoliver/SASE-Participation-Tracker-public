import * as React from 'react';
import { Box, Typography } from '@material-ui/core';
import { Link } from '@reach/router';
import { SerializedEvent, SerializedFormData } from '../../../../types/Event';
import FormType from '../../../../Enums';
import formatDate from '../../../../utils/formatDate';
import CardWithHeader from '../../../CardWithHeader/CardWithHeader';
import EventCardMenu from './EventCardMenu/EventCardMenu';

interface EventCardProps {
  event: SerializedEvent;
}

const EventCard: React.FC<EventCardProps> = ({ event }) => {
  const startTime = formatDate(new Date(event.start_time));
  const endTime = formatDate(new Date(event.end_time));

  const menu = <EventCardMenu event={event} />

  return (
    <CardWithHeader id={`event-card-${event.id}`} title={event.name} icon={menu}>
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
        </Typography>
        {event.forms.map((form: SerializedFormData) => (
          <Typography variant="body2" key={form.id}>
            {`${FormType[form.form_type as unknown as keyof typeof FormType]} (${form.user_count} respondant${form.user_count === 1 ? '' : 's'}): `}
            <Link to={`/form/${form.id}`}>{`${form.id}`}</Link>
          </Typography>
        ))}
      </div>
    </CardWithHeader>
  );
};

export default EventCard;
