import * as React from 'react';
import { RouteComponentProps, navigate } from '@reach/router';
import {
  Box, TextField, Button,
} from '@material-ui/core';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import getCSRFToken from '../../utils/getCSRFToken';

const LoginPage: React.FC<RouteComponentProps> = () => {
  const [username, setUsername] = React.useState('');
  const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setUsername(e.target.value);
  };

  const [password, setPassword] = React.useState('');
  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setPassword(e.target.value);
  };

  // Validate form info to show errors and determine whether to allow submit
  // const startTimeValid = !Number.isNaN(startTime.valueOf());
  // const endTimeValid = !Number.isNaN(startTime.valueOf());
  // TODO: perform validation
  const formValid = true; // name && startTimeValid && endTimeValid;

  const handleLogin = (): void => {
    if (!formValid) return;
    // Form is valid, post
    const body = {
      username,
      password,
    };

    fetch('/api/admins/sign_in', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
      body: JSON.stringify(body),
    }).then((response) => {
      if (response.ok) {
        navigate('/');
      } else { // something bad happened...
        // eslint-disable-next-line no-console
        console.log('error');
      }
    });
  };

  return (
    <Box margin="auto" width="50%" minWidth={500}>
      <CardWithHeader title="Log In">
        <Box paddingBottom={1}>
          <TextField
            id="username"
            required
            error={!username}
            label="Username"
            value={username}
            onChange={handleNameChange}
          />
        </Box>

        <Box paddingBottom={1}>
          <TextField
            id="standard-password-input"
            required
            error={!username}
            label="Password"
            type="password"
            value={password}
            onChange={handlePasswordChange}
            autoComplete="current-password"
          />
        </Box>
        <Button
          id="login"
          variant="contained"
          color="secondary"
          disabled={!formValid}
          onClick={handleLogin}
        >
          Log In
        </Button>
      </CardWithHeader>
    </Box>
  );
};

export default LoginPage;
