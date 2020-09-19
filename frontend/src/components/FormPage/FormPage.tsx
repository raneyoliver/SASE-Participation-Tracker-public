import * as React from 'react';
import { RouteComponentProps, navigate } from '@reach/router';
import {
  Box, TextField, Button,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { Event } from '../../types/Event';
import getCSRFToken from '../../utils/getCSRFToken';

const FormPage: React.FC<RouteComponentProps> = () => {
  const [UIN, setUIN] = React.useState('');
  const handleUINChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const re = /^[0-9]+$/;
    if (e.target.value === '' || re.test(e.target.value)) {
        setUIN(e.target.value);
    }
  };

  const UINValid = UIN && (UIN.length == 9);
  const formValid = UINValid;

  const handleSubmit = (): void => {
      console.log("submitted!");
      console.log(UIN);
    // if (!formValid) return;
    // // Form is valid, convert times to UTC format and post
    // const body: Event = {
    //   name,
    //   description,
    //   start_time: startTime.toUTCString(),
    //   end_time: endTime.toUTCString(),
    // };

    // fetch('/api/events/create', {
    //   method: 'POST',
    //   headers: {
    //     'Content-type': 'application/json',
    //     'X-CSRF-Token': getCSRFToken(),
    //   },
    //   body: JSON.stringify(body),
    // }).then(() => { // Once request has been processed, go back to homepage
    //   navigate('/');
    // });
  };

  return (
    <Box margin="10% auto" width="50%" minWidth={500}>
      <CardWithHeader title="Sign-in Form">
        <Box paddingBottom={1}>
          <TextField id="UIN" required error={!UINValid} label="UIN" value={UIN} onChange={handleUINChange} />
        </Box>

        <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
          Submit
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default FormPage;