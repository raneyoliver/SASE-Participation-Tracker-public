import * as React from 'react';
import { RouteComponentProps } from '@reach/router';
import {
  Box, TextField, Button, Tooltip,
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
  const formValid = (password_confirmation === password) && password_confirmation;

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
        window.location.href = '/';
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
        <Tooltip title={formValid ? '' : 'Fill in all fields to change password.'}>
          <span>
            <Button
              id="change-password"
              variant="contained"
              color="secondary"
              disabled={!formValid}
              onClick={handleSubmission}
            >
              Change Password
            </Button>
          </span>
        </Tooltip>
      </CardWithHeader>
    </Box>
  );
};

export default ChangePasswordPage;
