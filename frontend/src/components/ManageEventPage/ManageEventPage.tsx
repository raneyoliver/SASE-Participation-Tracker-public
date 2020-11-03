import * as React from 'react';
import { navigate } from '@reach/router';
import {
  Box, TextField, Button, InputLabel, MenuItem, FormControl, FormHelperText,
  Select, Typography, FormGroup, FormControlLabel, FormLabel, Switch, Checkbox, Tooltip,
} from '@material-ui/core';
import { DateTimePicker } from '@material-ui/pickers';
import AddIcon from '@material-ui/icons/Add';
import { makeStyles } from '@material-ui/core/styles';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { Event, SerializedEvent } from '../../types/Event';
import getCSRFToken from '../../utils/getCSRFToken';
import getFormRestriction from '../../utils/getFormRestriction';
import hasRSVP from '../../utils/hasRSVP';
import { EventType, FormType } from '../../Enums';

// Format datetimes like the following: 12/31/2020 12:00 PM
const dateFormat = 'MM/dd/yyyy hh:mm a';

interface ManageEventProps {
  eventId?: any;
}

const ManageEventPage: React.FC<ManageEventProps> = ({ eventId }) => {
  const [loading, setLoading] = React.useState(eventId !== undefined);

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
  const [createRSVPForm, setCreateRSVPForm] = React.useState(false);
  const handleCreateRSVPFormChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setCreateRSVPForm(e.target.checked);
    setDisabledButton(!disabledButton);
  };

  const useStyles = makeStyles(() => ({
    formLabel: {
      color: 'black',
    },
    removeMarginTop: {
      marginTop: -2,
    },
  }));
  const classes = useStyles();

  // Validate form info to show errors and determine whether to allow submit
  const startTimeValid = !Number.isNaN(startTime.valueOf());
  const endTimeValid = !Number.isNaN(startTime.valueOf());
  const formValid = name && startTimeValid && endTimeValid;

  // Get event data based on its id, return error page if not found
  React.useEffect(() => {
    if (eventId) {
      fetch(`/api/events/${eventId}`).then((response) => {
        if (response.status === 404) {
          window.location.href = '/edit_event/error';
        }
        return response.json();
      }).then((response: SerializedEvent) => {
        setName(response.name);
        setDescription(response.description);
        setStartTime(new Date(response.start_time));
        setEndTime(new Date(response.end_time));
        setEventType(response.event_type);
        setDisabledButton(!hasRSVP(response));
        setTimeRestriction({
          sign_in: getFormRestriction(FormType.SIGN_IN, response),
          rsvp: getFormRestriction(FormType.RSVP, response),
        });
      }).finally(() => setLoading(false));
    }
  }, [eventId]);

  const handleSubmit = (): void => {
    if (!formValid) return;

    const eventBody: Event = {
      name,
      description,
      start_time: startTime.toUTCString(),
      end_time: endTime.toUTCString(),
      event_type: eventType,
    };

    const createBody = {
      event: eventBody,
      create_rsvp_form: createRSVPForm,
      sign_in_restricted: timeRestriction.sign_in,
      rsvp_restricted: timeRestriction.rsvp,
    };

    const editBody = {
      id: eventId,
      event: eventBody,
      sign_in_restricted: timeRestriction.sign_in,
      rsvp_restricted: timeRestriction.rsvp,
    };

    if (eventId) { // Edit Event
      fetch('/api/events/update', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json',
          'X-CSRF-Token': getCSRFToken(),
        },
        body: JSON.stringify(editBody),
      }).then((response) => {
        if (response.status === 204) {
          window.location.href = '/';
        } else {
          navigate(`/edit_event/${eventId}`);
        }
      }); // Create Event
    } else {
      fetch('/api/events/create', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json',
          'X-CSRF-Token': getCSRFToken(),
        },
        body: JSON.stringify(createBody),
      }).then((response) => { // Once request has been processed, go back to homepage
        if (response.ok) {
          window.location.href = '/';
        } else { // something bad happened...
          navigate('/login');
        }
      });
    }
  };

  if (loading) {
    return (
      <Typography>
        Loading...
      </Typography>
    );
  }

  const RSVPCheckbox = <Checkbox id="event-create-RSVP-form" name="RSVPCheck" color="primary" checked={createRSVPForm} onChange={handleCreateRSVPFormChange} />;
  const addRSVPToEvent = (): any => (
    <Box paddingBottom={1}>
      <FormControlLabel id="event-create-RSVP" label="Create an RSVP Form for this event?" labelPlacement="start" style={{ marginLeft: 0 }} control={RSVPCheckbox} />
    </Box>
  );
  const submissionTipTitle = eventId ? 'update' : 'create';
  return (
    <Box margin="auto" width="50%" minWidth={500}>
      <CardWithHeader title={eventId ? 'Edit Event' : 'Create Event'}>
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

        <Box>
          { eventId ? <></> : addRSVPToEvent }
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
                control={(
                  <Tooltip classes={{ tooltip: classes.removeMarginTop }} title={!disabledButton ? '' : 'Must create RSVP form.'}>
                    <span>
                      <Switch disabled={disabledButton} checked={timeRestriction.rsvp} onChange={handleTimeRestrictionChange} id="rsvp" name="rsvp" color="primary" />
                    </span>
                  </Tooltip>
                )}
                label="RSVP"
              />
            </FormGroup>
          </FormControl>
        </Box>

        <Tooltip title={formValid ? '' : `Fill in all fields in red to ${submissionTipTitle} event.`}>
          <span>
            <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
              {eventId ? 'Update Event' : 'Create Event'}
            </Button>
          </span>
        </Tooltip>
      </CardWithHeader>
    </Box>
  );
};

export default ManageEventPage;
