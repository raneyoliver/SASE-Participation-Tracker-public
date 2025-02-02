import * as React from 'react';
import { RouteComponentProps } from '@reach/router';
import {
  Box, TextField, Button, Typography, Tooltip,
} from '@material-ui/core';
import CardWithHeader from '../CardWithHeader/CardWithHeader';
import getCSRFToken from '../../utils/getCSRFToken';

const LoginPage: React.FC<RouteComponentProps> = () => {
  const [error, setError] = React.useState(false);

  const [username, setUsername] = React.useState('');
  const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setUsername(e.target.value);
  };

  const [password, setPassword] = React.useState('');
  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>): void => {
    setPassword(e.target.value);
  };

  // Validate form info to show errors and determine whether to allow submit
  const formValid = username && password;

  const handleLogin = (): void => {
    setError(false);
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
        window.location.href = '/';
      } else {
        setError(true);
      }
    });
  };

  return (
    <CardWithHeader title="Log In" fixWidth>
      <Box paddingBottom={1}>
        <TextField
          id="username"
          required
          error={!username}
          label="Username"
          value={username}
          onChange={handleNameChange}
          autoComplete="username"
        />
      </Box>
      <Box paddingBottom={1}>
        <TextField
          id="password"
          required
          error={!username}
          label="Password"
          type="password"
          value={password}
          onChange={handlePasswordChange}
          onKeyPress={(e): void => { if (e.key === 'Enter') handleLogin(); }}
          autoComplete="current-password"
        />
      </Box>
      <Box>
        {error ? <Typography id="error-message" color="error">Error: Invalid Login</Typography> : null}
      </Box>
      <Tooltip title={formValid ? '' : 'Fill in all fields to log in.'}>
        <span>
          <Button
            id="login"
            variant="contained"
            color="secondary"
            disabled={!formValid}
            onClick={handleLogin}
          >
            Log In
          </Button>
        </span>
      </Tooltip>
    </CardWithHeader>
  );
};

export default LoginPage;
