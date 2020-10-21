import * as React from 'react';
import { RouteComponentProps, navigate } from '@reach/router';
import {
  Box, TextField, Button, FormLabel, FormControlLabel, Checkbox, InputLabel,
  MenuItem, FormControl, Select, Switch, FormGroup, FormHelperText,
} from '@material-ui/core';
import { DateTimePicker } from '@material-ui/pickers';
import AddIcon from '@material-ui/icons/Add';
import { makeStyles } from '@material-ui/core/styles';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { Event } from '../../types/Event';
import getCSRFToken from '../../utils/getCSRFToken';
import { EventType } from '../../Enums';

// Format datetimes like the following: 12/31/2020 12:00 PM
const dateFormat = 'MM/dd/yyyy hh:mm a';

const CreateEventPage: React.FC<RouteComponentProps> = () => {
  const [name, setName] = React.useState('');
  const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setName(e.target.value);
  };

  const [description, setDescription] = React.useState('');
  const handleDescriptionChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setDescription(e.target.value);
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

  const [disabledButton, setDisabledButton] = React.useState(true);
  const [createRSVPForm, setCreateRSVPForm] = React.useState(false);
  const handleCreateRSVPFormChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setCreateRSVPForm(e.target.checked);
    setDisabledButton(!disabledButton);
  };

  const [timeRestriction, setTimeRestriction] = React.useState({
    sign_in: false,
    rsvp: false,
  });
  const handleTimeRestrictionChange = (event: React.ChangeEvent<HTMLInputElement>): void => {
    setTimeRestriction({ ...timeRestriction, [event.target.name]: event.target.checked });
  };

  const useStyles = makeStyles(() => ({
    formLabel: {
      color: 'black',
    },
  }));
  const classes = useStyles();

  // Validate form info to show errors and determine whether to allow submit
  const startTimeValid = !Number.isNaN(startTime.valueOf());
  const endTimeValid = !Number.isNaN(startTime.valueOf());
  const formValid = name && startTimeValid && endTimeValid;

  const handleSubmit = (): void => {
    if (!formValid) return;
    // Form is valid, convert times to UTC format and post
    const eventBody: Event = {
      name,
      description,
      start_time: startTime.toUTCString(),
      end_time: endTime.toUTCString(),
      event_type: eventType,
      has_rsvp_form: createRSVPForm,
    };

    const body = {
      event: eventBody,
      create_rsvp_form: createRSVPForm,
      sign_in_restricted: timeRestriction.sign_in,
      rsvp_restricted: timeRestriction.rsvp,
    };

    fetch('/api/events/create', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => { // Once request has been processed, go back to homepage
      if (response.ok) {
        navigate('/');
      } else { // something bad happened...
        navigate('/login');
      }
    });
  };

  const RSVPCheckbox = <Checkbox id="event-create-RSVP-form" name="RSVPCheck" color="primary" checked={createRSVPForm} onChange={handleCreateRSVPFormChange} />;
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
          <FormControl>
            <InputLabel>Type</InputLabel>
            <Select value={eventType} onChange={handleTypeChange}>
              {option}
            </Select>
          </FormControl>
        </Box>

        <Box paddingBottom={1}>
          <DateTimePicker disablePast label="Start Time" format={dateFormat} value={startTime} onChange={handleStartTimeChange} />
        </Box>

        <Box paddingBottom={1}>
          <DateTimePicker disablePast label="End Time" format={dateFormat} value={endTime} onChange={handleEndTimeChange} />
        </Box>

        <Box paddingBottom={1}>
          <FormControlLabel id="event-create-RSVP" label="Create an RSVP Form for this event?" labelPlacement="start" style={{ marginLeft: 0 }} control={RSVPCheckbox} />
        </Box>

        <Box paddingBottom={1}>
          <FormControl>
            <FormLabel className={classes.formLabel}>
              Restrict Form Submission Time
            </FormLabel>
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
          Create Event
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default CreateEventPage;
