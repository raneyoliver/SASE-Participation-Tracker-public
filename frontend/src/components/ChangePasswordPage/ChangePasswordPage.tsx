import * as React from 'react';
import { RouteComponentProps, navigate } from '@reach/router';
import {
  Box, TextField, Button,
} from '@material-ui/core';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import getCSRFToken from '../../utils/getCSRFToken';

const ChangePasswordPage: React.FC<RouteComponentProps> = () => {
  const [password, setPassword] = React.useState('');
  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setPassword(e.target.value);
  };

  const [password_confirmation, setPasswordConfirmation] = React.useState('');
  const handlePasswordConfirmationChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setPasswordConfirmation(e.target.value);
  };

  // Validate form info to show errors and determine whether to allow submit
  const formValid = password_confirmation === password;

  const handleSubmission = (): void => {
    if (!formValid) return;
    // Form is valid, post
    const body = {
      password,
    };

    fetch('/api/admins/', {
      method: 'PUT',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.ok) {
        navigate('/');
      }
    });
  };

  return (
    <Box margin="auto" width="50%" minWidth={500}>
      <CardWithHeader title="Change Password">
        <Box paddingBottom={1}>
          <TextField
            id="password"
            required
            error={!password}
            label="New Password"
            type="password"
            value={password}
            onChange={handlePasswordChange}
          />
        </Box>

        <Box paddingBottom={1}>
          <TextField
            id="password-confirmation"
            required
            error={!password_confirmation}
            label="Password Confirmation"
            type="password"
            value={password_confirmation}
            onChange={handlePasswordConfirmationChange}
          />
        </Box>
        <Button
          id="change-password"
          variant="contained"
          color="secondary"
          disabled={!formValid}
          onClick={handleSubmission}
        >
          Change Password
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default ChangePasswordPage;
