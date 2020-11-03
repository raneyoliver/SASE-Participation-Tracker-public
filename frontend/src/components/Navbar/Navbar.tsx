import * as React from 'react';
import {
  AppBar, Toolbar, ButtonBase, Typography,
  IconButton, Box,
} from '@material-ui/core';
import HelpIcon from '@material-ui/icons/Help';

// Renders a navigation bar with a link to the homepage
const NavBar: React.SFC = () => {
  const handleTitleClick = (): void => { window.location.href = '/'; };
  const handleHelpClick = (): void => { window.location.href = '/help'; };

  return (
    <AppBar position="sticky">
      <Toolbar>
        <Box flexGrow={1} justifyContent="flex-start">
          <ButtonBase onClick={handleTitleClick}>
            <Typography variant="h6">
              SASE Participation Tracker
            </Typography>
          </ButtonBase>
        </Box>
        <Box justifyContent="flex-end">
          <IconButton id="help" color="inherit" onClick={handleHelpClick}>
            <HelpIcon />
          </IconButton>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default NavBar;
