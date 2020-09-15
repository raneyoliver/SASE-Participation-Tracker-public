import * as React from 'react';
import { navigate } from '@reach/router';
import {
  AppBar, Toolbar, ButtonBase, Typography,
} from '@material-ui/core';

// Renders a navigation bar with a link to the homepage
const NavBar: React.SFC = () => {
  const handleTitleClick = (): void => { navigate('/'); };

  return (
    <AppBar position="sticky">
      <Toolbar>
        <ButtonBase onClick={handleTitleClick}>
          <Typography variant="h6">
            SASE Participation Tracker
          </Typography>
        </ButtonBase>
      </Toolbar>
    </AppBar>
  );
};

export default NavBar;
