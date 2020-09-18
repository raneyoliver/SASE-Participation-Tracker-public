import * as React from 'react';
import { RouteComponentProps, navigate } from '@reach/router';
import {
  Box, TextField, Button,
} from '@material-ui/core';
import AddIcon from '@material-ui/icons/Add';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import { SignInForm } from '../../types/SignInForm';
import getCSRFToken from '../../utils/getCSRFToken';

const SignInFormPage: React.FC<RouteComponentProps> = () => {
  const [UIN, setUIN] = React.useState('');
  const handleUINChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setUIN(e.target.value);
  };

  // Validate form info to show errors and determine whether to allow submit
  const formValid = (UIN != '');

  const handleSubmit = (): void => {
    if (!formValid) return;
    // Form is valid, convert times to UTC format and post
    const body: SignInForm = {
      UIN
    };

    fetch('/api/events/create', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then(() => { // Once request has been processed, go back to homepage
      navigate('/');
    });
  };

  return (
    <Box margin="auto" width="50%" minWidth={500}>
      <CardWithHeader title="Sign-In Form">
        <Box paddingBottom={1}>
          <TextField id="uin" required error={!UIN} label="UIN" value={UIN} onChange={handleUINChange} />
        </Box>

        <Button id="submit" variant="contained" color="secondary" disabled={!formValid} startIcon={<AddIcon />} onClick={handleSubmit}>
          Sign In!
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default SignInFormPage;
