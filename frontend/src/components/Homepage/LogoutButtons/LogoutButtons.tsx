import * as React from 'react';
import {
  Box, Button, Typography,
} from '@material-ui/core';
import { navigate } from '@reach/router';
import getCSRFToken from '../../../utils/getCSRFToken';

interface LogoutButtonsProps {
  id: string;
}

const LogoutButtons: React.FC<LogoutButtonsProps> = () => {

  const handleLogoutClick = (): void => {
    fetch('/api/admins/sign_out', {
      method: 'DELETE',
      headers: {
        'Content-type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      },
    }).then((response) => {
      if (response.ok) {
        navigate('/login');
      }
    });
  };

  return (
    <Box display="flex" alignItems="center">
      <Button id="logout" variant="contained" color="secondary" onClick={handleLogoutClick}>
        Log Out
      </Button>
    </Box>
  );
};

export default LogoutButtons;
