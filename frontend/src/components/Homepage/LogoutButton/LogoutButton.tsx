import * as React from 'react';
import {
  Box, Button,
} from '@material-ui/core';
import { navigate } from '@reach/router';
import getCSRFToken from '../../../utils/getCSRFToken';

interface LogoutButtonsProps {
  id: string;
}

const LogoutButton: React.FC<LogoutButtonsProps> = () => {
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
    <Button id="logout" variant="contained" color="secondary" onClick={handleLogoutClick}>
      Log Out
    </Button>
  );
};

export default LogoutButton;
