import * as React from 'react';
import {
  AppBar, Toolbar, ButtonBase, Typography,
} from '@material-ui/core';

// Renders a navigation bar with a link to the homepage
const NavBar: React.SFC = () => {
  const handleTitleClick = (): void => { window.location.href = '/'; };

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
