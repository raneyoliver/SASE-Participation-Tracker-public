import * as React from 'react';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import {
  Box, TextField, Button, Typography,
} from '@material-ui/core';
import { DateTimePicker } from '@material-ui/pickers';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { Event } from '../../types/Event';
import getCSRFToken from '../../utils/getCSRFToken';

// Format datetimes like the following: 12/31/2020 12:00 PM
const dateFormat = 'MM/dd/yyyy hh:mm a';

const EditEventPage: React.FC<RouteComponentProps> = () => {
  const { eventId } = useParams();

  const [loading, setLoading] = React.useState(true);
  const [event, setEvent] = React.useState<Event>();
  React.useEffect(() => {
    fetch(`/api/events/${eventId}`).then((response) => {
      if (response.status === 404) {
        window.location.href = '/event/error';
      }
      return response.json();
    }).then((response: Event) => {
      setEvent(response);
    }).finally(() => setLoading(false));
  }, [eventId]);

  const [name, setName] = React.useState('');
  const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setName(e.target.value);
  };

  const [description, setDescription] = React.useState('');
  const handleDescriptionChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setDescription(e.target.value);
  };

  // Initialize startTime to current time
  const [startTime, setStartTime] = React.useState(new Date());
  // Initialize endTime to current time + 1 hour
  const [endTime, setEndTime] = React.useState(new Date(Date.now() + (60 * 60 * 1000)));

  const handleStartTimeChange = (date: Date): void => {
    setStartTime(date);
    // If end time comes beforenew start time, set it to an hour afterwards to keep valid
    if (date > endTime) setEndTime(new Date(date.valueOf() + 60 * 60 * 1000));
  };

  const handleEndTimeChange = (date: Date): void => {
    setEndTime(date);
    // If start time comes after new end time, set it to an hour before to keep valid
    if (date < startTime) setStartTime(new Date(date.valueOf() - 60 * 60 * 1000));
  };

  // Validate form info to show errors and determine whether to allow submit
  const startTimeValid = !Number.isNaN(startTime.valueOf());
  const endTimeValid = !Number.isNaN(startTime.valueOf());
  const formValid = name && startTimeValid && endTimeValid;

  const handleSubmit = (): void => {
    if (!formValid) return;
    // Form is valid, convert times to UTC format and post
    const body: Event = {
      name,
      description,
      start_time: startTime.toUTCString(),
      end_time: endTime.toUTCString(),
    };
    fetch('/api/events/update', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => { // Once request has been processed, go back to homepage
      if (response.status === 204) {
        navigate('/');
      } else { // something bad happened...
        navigate(`/edit_event/${eventId}`);
      }
    });
  };

  if (loading) {
    return (
      <Typography>
        Loading...
      </Typography>
    );
  }

  return (
    <Box margin="auto" width="50%" minWidth={500}>
      <CardWithHeader title="Create New Event">
        <Box paddingBottom={1}>
          <TextField id="event-name" required error={!name} label="Name" value={name} onChange={handleNameChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="event-description" multiline fullWidth label="Description" value={description} onChange={handleDescriptionChange} />
        </Box>

        <Box paddingBottom={1}>
          <DateTimePicker disablePast label="Start Time" format={dateFormat} value={startTime} onChange={handleStartTimeChange} />
        </Box>

        <Box paddingBottom={1}>
          <DateTimePicker disablePast label="End Time" format={dateFormat} value={endTime} onChange={handleEndTimeChange} />
        </Box>

        <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
          Update Event
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default EditEventPage;
