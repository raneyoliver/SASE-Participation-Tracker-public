import * as React from 'react';
import { RouteComponentProps, navigate, useParams } from '@reach/router';
import {
  Box, TextField, Button, InputLabel, MenuItem, FormControl, FormHelperText,
  Select, Typography, FormGroup, FormControlLabel, FormLabel, Switch,
} from '@material-ui/core';
import { DateTimePicker } from '@material-ui/pickers';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { Event, SerializedEvent } from '../../types/Event';
import getCSRFToken from '../../utils/getCSRFToken';
import getFormRestriction from '../../utils/getFormRestriction';
import { EventType } from '../../Enums';

// Format datetimes like the following: 12/31/2020 12:00 PM
const dateFormat = 'MM/dd/yyyy hh:mm a';

const EditEventPage: React.FC<RouteComponentProps> = () => {
  const { eventId } = useParams();

  const [loading, setLoading] = React.useState(true);

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

  // Event Type
  const [eventType, setEventType] = React.useState<EventType>(EventType.gbm);
  const handleTypeChange = (e: React.ChangeEvent<{ value: EventType }>): void => {
    setEventType(e.target.value);
  };

  const option = Object.values(EventType).map((value) => (
    <MenuItem key={value} value={value}>
      {value}
    </MenuItem>
  ));

  const [disabledButton, setDisabledButton] = React.useState(true);
  const [timeRestriction, setTimeRestriction] = React.useState({
    sign_in: false,
    rsvp: false,
  });
  const handleTimeRestrictionChange = (event: React.ChangeEvent<HTMLInputElement>): void => {
    setTimeRestriction({ ...timeRestriction, [event.target.name]: event.target.checked });
  };

  // Validate form info to show errors and determine whether to allow submit
  const startTimeValid = !Number.isNaN(startTime.valueOf());
  const endTimeValid = !Number.isNaN(startTime.valueOf());
  const formValid = name && startTimeValid && endTimeValid;

  // Get event data based on its id, return error page if not found
  React.useEffect(() => {
    fetch(`/api/events/${eventId}`).then((response) => {
      if (response.status === 404) {
        window.location.href = '/edit_event/error';
      }
      return response.json();
    }).then((response: Event) => {
      setName(response.name);
      setDescription(response.description);
      setStartTime(new Date(response.start_time));
      setEndTime(new Date(response.end_time));
      setEventType(response.event_type);
      setDisabledButton(!response.has_rsvp_form);
      setTimeRestriction({
        sign_in: getFormRestriction('sign-in', response as unknown as SerializedEvent),
        rsvp: getFormRestriction('RSVP', response as unknown as SerializedEvent),
      });
    }).finally(() => setLoading(false));
  }, [eventId]);

  const handleSubmit = (): void => {
    if (!formValid) return;

    const eventBody: Event = {
      name,
      description,
      start_time: startTime.toUTCString(),
      end_time: endTime.toUTCString(),
      event_type: eventType,
      has_rsvp_form: !disabledButton,
    };

    const body = {
      id: eventId,
      event: eventBody,
      sign_in_restricted: timeRestriction.sign_in,
      rsvp_restricted: timeRestriction.rsvp,
    };

    fetch('/api/events/update', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.status === 204) {
        navigate('/');
      } else {
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
      <CardWithHeader title="Edit Event">
        <Box paddingBottom={1}>
          <TextField id="event-name" required error={!name} label="Name" value={name} onChange={handleNameChange} />
        </Box>

        <Box paddingBottom={1}>
          <TextField id="event-description" multiline fullWidth label="Description" value={description} onChange={handleDescriptionChange} />
        </Box>

        <Box paddingBottom={1}>
          <DateTimePicker label="Start Time" format={dateFormat} value={startTime} onChange={handleStartTimeChange} />
        </Box>

        <Box paddingBottom={1}>
          <DateTimePicker label="End Time" format={dateFormat} value={endTime} onChange={handleEndTimeChange} />
        </Box>

        <Box paddingBottom={1}>
          <FormControl>
            <InputLabel>Type</InputLabel>
            <Select value={eventType} onChange={handleTypeChange}>
              {option}
            </Select>
          </FormControl>
        </Box>

        <Box paddingBottom={1}>
          <FormControl component="fieldset">
            <FormLabel component="legend">Restrict Form Submission Time</FormLabel>
            <FormGroup>
              <FormHelperText>
                (If enabled,
                Sign-In forms will only be accessible during the event and
                RSVP forms will only be accessible before the event.)
              </FormHelperText>
              <FormControlLabel
                control={<Switch checked={timeRestriction.sign_in} onChange={handleTimeRestrictionChange} id="sign_in" name="sign_in" color="primary" />}
                label="Sign-In"
              />
              <FormControlLabel
                control={<Switch disabled={disabledButton} checked={timeRestriction.rsvp} onChange={handleTimeRestrictionChange} id="rsvp" name="rsvp" color="primary" />}
                label="RSVP"
              />
            </FormGroup>
          </FormControl>
        </Box>

        <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
          Update Event
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default EditEventPage;
